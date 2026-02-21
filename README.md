# Tasman Dynamics - Interaction Framework

[Image of a high-fidelity helicopter cockpit in a flight simulator with interactive UI elements]

A standalone, high-performance clickable cockpit and 3D interaction engine for Arma 3. 

Developed by **Tasman Dynamics**, this framework bridges the gap between traditional Arma 3 vehicle controls and high-fidelity flight simulation. It allows players to seamlessly interact with 3D cockpit switches, knobs, and panels using a detached mouse cursor—all without pausing the game or breaking simulation.

## ✨ Key Features

* **Detached Interactive Cursor:** Decouples mouse movement from head-tracking, allowing pilots to keep one hand on their HOTAS/Collective while using the mouse to manipulate cockpit systems.
* **High-Performance 3D Raycasting:** Uses optimized engine-level math (`distance2D`, `worldToScreen`) to project 3D vehicle memory points onto the player's 2D screen with zero framerate drops.
* **Dynamic Visual Feedback:** The standard crosshair dynamically morphs into an interactive icon (and changes color) the moment a clickable node is detected.
* **Rotary Dial Support:** Intercepts the Z-axis (mouse scroll wheel) while the UI is open, allowing players to smoothly rotate radio frequencies, lighting knobs, and volume dials without triggering the vanilla Arma action menu.
* **Camera Snapping:** Allows pilots to instantly snap their camera view to specific overhead panels or center consoles for easier interaction, complete with customized FOV.
* **Zero Dependencies:** Built entirely on vanilla Arma 3 UI and SQF. **No CBA_A3 requirement.**

## 🏗️ Architecture Philosophy

This repository contains **only the interaction engine**. It does not contain any vehicle models, textures, or specific flight logic. 

By keeping the interaction math completely decoupled from proprietary assets, server admins can run this framework as a lightweight, universal dependency, and community modders can easily hook their own vehicles into the system.

## 🛠️ Building from Source

This project utilizes [HEMTT](https://github.com/BrettMayson/HEMTT) (Highly Extensible Modding Toolchain) for compilation, rapification, and PBO packing.

### Prerequisites
* [HEMTT](https://github.com/BrettMayson/HEMTT/releases) installed and added to your system PATH.

### Build Instructions
1. Clone this repository to your local machine.
2. Open a terminal in the root directory of the repository.
3. Run the following build command:
   ```bash
   hemtt build
   ```
4. The compiled @Tasman Dynamics - Interaction Framework folder will be output to .hemtt/out/build/.

## 🤝 Contributing & Compatibility
If you want to make a vanilla Arma 3 vehicle or a third-party mod (like RHS, CUP, or Hatchet) clickable using this engine, do not submit vehicle configs here.

Please visit our companion repository: TasDyn-Interaction-Compat (Link to be updated).

There, you can submit simple JSON files containing memory points and labels. Our automated TypeScript compiler will parse your submission and generate the necessary SQF/CPP injection code to hook your favorite vehicles into this framework.

📄 License
This framework is released under the Arma Public License Share Alike (APL-SA).
You are free to use it, learn from it, and require it as a dependency for your own vehicle mods, provided that your work is kept within the Arma universe, is strictly non-commercial, and any modifications to this framework are released under the same license. For full details, see the LICENSE file.