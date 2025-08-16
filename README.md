
# Godot Scripts Collection

This repository contains a set of reusable scripts and shaders for Godot Engine projects, focused on 2D and 3D game development. The scripts are organized by functionality and are designed to be modular, making it easy to integrate them into your own Godot projects.

## Contents

### Components-2D
Reusable 2D components for common gameplay mechanics:
- **floating_numbers_component.gd**: Displays floating numbers (e.g., damage, healing) above entities.
- **health_component.gd**: Manages health, damage, and healing logic for entities.
- **hitbox_component.gd**: Handles hit detection and collision for attacks.
- **hurtbox_component.gd**: Defines areas that can receive damage or effects.
- **inventory_component.gd**: Basic inventory system for holding items.
- **item_holder_component.gd**: Manages item pickup, holding, and dropping.
- **knockback_component.gd**: Applies knockback effects to entities upon impact.
- **velocity_component.gd**: Controls entity movement and velocity.

### Managers-2D
- **audio_manager.gd**: Centralized audio management for playing sound effects and music.

### Shaders-2D
- **hit_flash_shader.gdshader**: Shader for creating a hit flash effect on 2D sprites (e.g., when taking damage).

### Shaders-3D
- **pixel_art_shader_3d.gdshader**: Pixel art style shader for 3D, useful for stylized games.

## Usage
1. **Copy** the desired scripts or shaders into your Godot project.
2. **Attach** scripts to nodes as needed, or add shaders to materials.
3. **Configure** exported variables in the Godot editor to fit your game's requirements.

## Requirements
- Godot Engine 4.x (scripts are GDScript)

## Contributing
Contributions are welcome! Feel free to submit pull requests for bug fixes, improvements, or new components.

---

**Author:** liamhallbrg

For questions or suggestions, open an issue or contact the repository owner.
