# Tasman Dynamics - Interaction Framework

A standalone, high-performance Data Bus-driven 3D interaction engine for Arma 3.

Developed by Tasman Dynamics, this framework bridges the gap between traditional Arma 3 vehicle controls and professional-grade flight simulation. It allows pilots to interact with complex cockpit systems using a detached mouse cursor, driven by a logic-first architecture inspired by real-world aviation standards.

## ✨ Key Features

* Detached Interactive Cursor: Decouples mouse movement from head-tracking. Pilots can maintain flight stability on a HOTAS or Collective while manipulating overhead panels or center consoles.
* Data Bus Emulation (DBE): Moves away from "script-per-switch" logic. Interactions are processed as digital "Words" (bitmasks) across a simulated data bus, mirroring the ARINC 429 and MIL-STD-1553 standards.
* Deterministic Multiplayer Sync: High-fidelity synchronization ensures every crew member sees the exact same instrument state. Uses a request-response pattern to validate switch actions against vehicle power and damage states before broadcasting.
* High-Performance 3D Raycasting: Optimized engine-level math (worldToScreen and memory-point projection) ensures zero framerate impact, even in cockpits with hundreds of interactive nodes.
* Rotary Dial & Axis Support: Intercepts the Z-axis (scroll wheel) to allow for smooth, analog-style control of radio frequencies, lighting dimmers, and volume knobs.
* Zero Dependencies: Built entirely on vanilla Arma 3 UI and SQF. No CBA_A3 requirement.

## 🛰️ The Engineering: Data Bus Emulation

To achieve maximum realism and network efficiency, the framework treats the cockpit as a digital ecosystem rather than a collection of independent scripts.

### System-Oriented Synchronization
Instead of syncing 200 individual variables for 200 switches, the framework packs switch states into System Words using bitmasking. A single integer can represent the state of an entire electrical bus or fuel panel.



### Master Bus Controller Logic
The vehicle "Owner" (the Pilot) acts as the Bus Controller.
1. Request: A co-pilot clicks a switch.
2. Validation: The request is sent to the Pilot's machine. The framework checks if the system has power and is not damaged.
3. Execution: If valid, the Pilot’s machine updates the "System Word."
4. Broadcast: The updated state is synced to all clients, triggering local animations and sound effects simultaneously.

## 🏗️ Architecture Philosophy

This repository contains the core interaction engine. It is strictly decoupled from proprietary assets.

By separating the math and network logic from vehicle models, server admins can run this framework as a lightweight, universal dependency. Community modders can hook their own vehicles into the system by simply providing a data-driven configuration.

## 🛠️ Building from Source

This project utilizes HEMTT (Highly Extensible Modding Toolchain) for compilation and PBO packing.

### Prerequisites
* HEMTT (https://github.com/BrettMayson/HEMTT/releases) installed and added to your system PATH.

### Build Instructions
1. Clone this repository.
2. Open a terminal in the root directory.
3. Run the build command:
   hemtt build
4. The compiled @Tasman Dynamics - Interaction Framework folder will be located in .hemtt/out/build/.

## 🤝 Contributing & Compatibility

We utilize a Data-Driven Configuration model. If you wish to make a vehicle (Vanilla, RHS, CUP, etc.) compatible with this engine, you do not need to write SQF.

Please visit our companion repository: TasDyn-Interaction-Compat (Link Pending).

Submit a JSON file containing your vehicle's memory points and system logic. Our TypeScript-based compiler will parse your submission and generate the necessary injection code to hook the vehicle into the framework.

## 📄 License

This framework is released under the Arma Public License Share Alike (APL-SA).
Non-commercial use, modification, and redistribution are permitted, provided the work remains within the Arma universe and any derivatives are released under the same license. See the LICENSE file for full details.