extends Node2D
class_name ItemHolderComponent

@export var inventory_component : InventoryComponent
@onready var item_position: Node2D = $ItemPosition

var current_item_index : int = 0
var current_item_node : Node2D
var current_item : PackedScene

signal ItemChanged

func _ready() -> void:
	if (!inventory_component):
		printerr("Missing InventoryComponent on " + str(get_path()) + "'s ItemHolderComponent")
	elif !inventory_component.is_inventory_empty():
		current_item = inventory_component.get_item_by_index(current_item_index)
		_change_to_item()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory_item_next"):
		change_item_next()
	if event.is_action_pressed("inventory_item_previous"):
		change_item_previous()


func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())


func change_item_next() -> void:
	var next_index = (current_item_index + 1) % inventory_component.get_inventory_size()
	if next_index == current_item_index: return
	current_item_index = next_index
	current_item = inventory_component.get_item_by_index(current_item_index)
	_change_to_item()


func change_item_previous() -> void:
	var prev_index = (current_item_index - 1) % inventory_component.get_inventory_size()
	if prev_index == current_item_index: return
	current_item_index = prev_index
	current_item = inventory_component.get_item_by_index(current_item_index)
	_change_to_item()


func _change_to_item()->void:
	if current_item_node:
		current_item_node.queue_free()
	current_item_node = current_item.instantiate()
	item_position.add_child(current_item_node)
	ItemChanged.emit(current_item)
