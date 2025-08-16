
# Godot Scripts Collection

This repository contains a set of reusable scripts and shaders for Godot Engine projects, focused on 2D and 3D game development. The scripts are organized by functionality and are designed to be modular, making it easy to integrate them into your own Godot projects.

## Contents


### Components-2D
Reusable 2D components and scenes for common gameplay mechanics:
- **camera_shake.gd**: Adds camera shake effects using noise for dynamic feedback.
- **floating_number.tscn**: Scene for displaying floating numbers (e.g., damage, healing) above entities.
- **floating_numbers_component.gd**: Spawns and manages floating numbers for visual feedback.
- **health_component.gd**: Manages health, damage, healing, and death logic for entities.
- **hitbox_component.gd**: Handles hit detection and collision for attacks, emits damage to hurtboxes.
- **hurtbox_component.gd**: Receives damage, connects to health, and emits hit signals.
- **inventory_component.gd**: Basic inventory system for holding, adding, and removing items.
- **item_holder_component.gd**: Manages item pickup, holding, switching, and dropping.
- **knockback_component.gd**: Applies knockback effects to entities using velocity.
- **velocity_component.gd**: Controls entity movement, acceleration, and velocity logic.


### Managers-2D
- **audio_manager.gd**: Centralized audio management for music, sound effects, and audio settings.


### Shaders-2D
- **hit_flash_shader.gdshader**: Shader for creating a hit flash effect on 2D sprites (e.g., when taking damage).


### Shaders-3D
- **pixel_art_shader_3d.gdshader**: Pixel art style shader for 3D models, useful for stylized games.

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
