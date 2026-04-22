# 🎮 Tasman Dynamics - Interaction Framework

[![License: APL-SA](https://img.shields.io/badge/License-APL%20SA-blue.svg)](LICENSE)
[![Language: SQF](https://img.shields.io/badge/Language-SQF-informational.svg)](https://community.bistudio.com/)
[![Arma 3](https://img.shields.io/badge/Arma-3-critical.svg)](https://arma3.com/)

> A standalone, high-performance **Data Bus-driven 3D interaction engine** for Arma 3.

Developed by Tasman Dynamics, this framework bridges the gap between traditional Arma 3 vehicle controls and professional-grade flight simulation. It allows pilots to interact with complex cockpit systems using a detached mouse cursor, driven by a logic-first architecture inspired by real-world aviation standards.

---

### 🎯 Overview

<table>
<tr>
<td align="center">
  <b>🖱️ Detached Cursor</b><br/>
  Mouse Independence
</td>
<td align="center">
  <b>📊 Data Bus</b><br/>
  Bitmask Logic
</td>
<td align="center">
  <b>🎯 3D Raycasting</b><br/>
  Engine Optimized
</td>
</tr>
<tr>
<td align="center">
  <b>🎛️ Rotary Dials</b><br/>
  Analog Control
</td>
<td align="center">
  <b>🔄 MP Sync</b><br/>
  Deterministic
</td>
<td align="center">
  <b>⚡ Zero Deps</b><br/>
  Pure SQF
</td>
</tr>
</table>

## ✨ Key Features

| Feature | Description |
|---------|-------------|
| 🖱️ **Detached Interactive Cursor** | Decouples mouse movement from head-tracking. Pilots can maintain flight stability on a HOTAS or Collective while manipulating overhead panels or center consoles. |
| 📊 **Data Bus Emulation (DBE)** | Moves away from "script-per-switch" logic. Interactions are processed as digital "Words" (bitmasks) across a simulated data bus, mirroring the ARINC 429 and MIL-STD-1553 standards. |
| 🔄 **Deterministic Multiplayer Sync** | High-fidelity synchronization ensures every crew member sees the exact same instrument state. Uses a request-response pattern to validate switch actions against vehicle power and damage states before broadcasting. |
| ⚡ **High-Performance 3D Raycasting** | Optimized engine-level math (worldToScreen and memory-point projection) ensures zero framerate impact, even in cockpits with hundreds of interactive nodes. |
| 🎛️ **Rotary Dial & Axis Support** | Intercepts the Z-axis (scroll wheel) to allow for smooth, analog-style control of radio frequencies, lighting dimmers, and volume knobs. |
| 🚀 **Zero Dependencies** | Built entirely on vanilla Arma 3 UI and SQF. No CBA_A3 requirement. |

## 🛰️ The Engineering: Data Bus Emulation

To achieve maximum realism and network efficiency, the framework treats the cockpit as a digital ecosystem rather than a collection of independent scripts.

### System-Oriented Synchronization

Instead of syncing 200 individual variables for 200 switches, the framework packs switch states into System Words using bitmasking. A single integer can represent the state of an entire electrical bus or fuel panel.

```
Traditional Approach          Data Bus Emulation Approach
────────────────────        ──────────────────────────────
var_switch_1                System Word (Integer)
var_switch_2                ┌─────────────────┐
var_switch_3                │ 0 1 0 1 1 0 1 0 │  (8 switches)
var_switch_4                ├─────────────────┤
var_switch_5                │ Bitmasking      │
var_switch_6                │ Efficient Sync  │
var_switch_7                │ Low Bandwidth   │
var_switch_8                └─────────────────┘

❌ 8 network transmissions  ✅ 1 network transmission
❌ High bandwidth            ✅ Minimal overhead
```

### Master Bus Controller Logic

The vehicle "Owner" (the Pilot) acts as the Bus Controller.

```
┌──────────────┐
│  Co-Pilot    │
│  Clicks      │
│  Switch      │
└──────┬───────┘
       │
       │ 1️⃣ REQUEST
       ▼
┌─────────────────────────────┐
│      Pilot's Machine        │
│  ┌─────────────────────┐    │
│  │ Validation Check    │    │
│  ├─────────────────────┤    │
│  │ • Power State?      │    │
│  │ • System Damaged?   │    │
│  │ • Authority Check?  │    │
│  └─────────────────────┘    │
└──────┬──────────────────────┘
       │
       ├─ ❌ Invalid → Reject
       │
       └─ ✅ Valid
          │
          │ 2️⃣ UPDATE
          ▼
     ┌──────────────┐
     │ System Word  │
     │   Updated    │
     └────┬─────────┘
          │
          │ 3️⃣ BROADCAST
          ▼
    ┌────────────────┐
    │  All Clients   │
    │  • Animation   │
    │  • Sounds      │
    │  • UI Update   │
    └────────────────┘
```

**Flow Steps:**
1. **Request:** A co-pilot clicks a switch.
2. **Validation:** The request is sent to the Pilot's machine. The framework checks if the system has power and is not damaged.
3. **Execution:** If valid, the Pilot's machine updates the "System Word."
4. **Broadcast:** The updated state is synced to all clients, triggering local animations and sound effects simultaneously.

## 🏗️ Architecture Philosophy

This repository contains the core interaction engine. It is strictly decoupled from proprietary assets.

By separating the math and network logic from vehicle models, server admins can run this framework as a lightweight, universal dependency. Community modders can hook their own vehicles into the system by simply providing a data-driven configuration.

```
┌──────────────────────────────────────────────────────┐
│   Tasman Dynamics Interaction Framework (Core)       │
│                                                      │
│  ┌──────────────┐  ┌──────────────┐  ┌────────────┐  │
│  │ 3D Raycasting│  │  Data Bus    │  │  Multiplayer│ │
│  │    Engine    │  │  Emulation   │  │    Sync    │  │
│  └──────┬───────┘  └──────┬───────┘  └────┬───────┘  │
│         └─────────────────┴────────────────┘         │
│                      │                               │
└──────────────────────┼───────────────────────────────┘
                       │
         ┌─────────────┴─────────────┐
         │                           │
    ┌────▼────┐               ┌──────▼──────┐
    │ Vehicle │               │  Vehicles   │
    │ Config  │               │  (Modded)   │
    │ (JSON)  │               │             │
    └─────────┘               └─────────────┘
```

## 🛠️ Building from Source

This project utilizes **HEMTT** (Highly Extensible Modding Toolchain) for compilation and PBO packing.

### Prerequisites

- **HEMTT** ([Get Latest Release](https://github.com/BrettMayson/HEMTT/releases)) — installed and added to your system PATH

### Build Instructions

```bash
# 1. Clone this repository
git clone <repo-url>

# 2. Navigate to the root directory
cd Tasman-Dynamics-Interaction-Framework

# 3. Build the project
hemtt build

# ✅ Output: .hemtt/out/build/@Tasman Dynamics - Interaction Framework/
```

**Build Process Flow:**

```
Source Code
    ↓
┌─────────────────┐
│  hemtt build    │
│  • Compile SQF  │
│  • Pack PBO     │
│  • Validate     │
└────────┬────────┘
         ↓
  .hemtt/out/build/
  @Tasman Dynamics - Interaction Framework
         ↓
    Ready for Deploy
```

## 🤝 Contributing & Compatibility

We utilize a **Data-Driven Configuration model**. If you wish to make a vehicle (Vanilla, RHS, CUP, etc.) compatible with this engine, you do not need to write SQF.

### How It Works

```
Your Vehicle Model
        ↓
  Create JSON Config
  • Memory Points
  • System Logic
  • Switch States
        ↓
 Submit to TasDyn-Interaction-Compat
        ↓
┌──────────────────────────┐
│ TypeScript Compiler      │
│ • Parse Config           │
│ • Generate Injection     │
│ • Auto-Hook Vehicle      │
└──────────┬───────────────┘
           ↓
    ✅ Vehicle Ready
       for Framework
```

### Getting Started

Please visit our companion repository: **[TasDyn-Interaction-Compat](link-pending)** 

**Supported Vehicles:** Vanilla, RHS, CUP, and community addons

Submit a JSON file containing your vehicle's memory points and system logic. Our TypeScript-based compiler will parse your submission and generate the necessary injection code to hook the vehicle into the framework.

## 📄 License

This framework is released under the **Arma Public License Share Alike (APL-SA)**.

- ✅ Non-commercial use, modification, and redistribution permitted
- ✅ Must remain within the Arma universe
- ✅ Derivatives must be released under the same license

See the [LICENSE](LICENSE) file for full details.

---

<div align="center">

### 🎯 Join the Community

Made with ❤️ by **Tasman Dynamics**

[📚 Documentation](docs/) • [🐛 Report Issues](issues/) • [💬 Discussions](discussions/) • [📢 Announcements](announcements/)

```
╔════════════════════════════════════════════╗
║  Fly Realistic. Interact Authentically.    ║
║  Build Tomorrow's Aviation Experience.     ║
╚════════════════════════════════════════════╝
```

</div>