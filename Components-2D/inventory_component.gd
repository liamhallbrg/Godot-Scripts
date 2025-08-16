extends Node
class_name InventoryComponent

@export var inventory : Array[PackedScene] = []
@export var max_inventory_size : int = 20


func add_item_to_inventory(item:Item) -> bool:
	if is_inventory_full(): return false
	inventory.append(item)
	return true


func remove_item_from_inventory(item:Item) -> bool:
	if is_inventory_empty(): return false
	inventory.erase(item)
	return true


func get_item_by_index(index : int) -> PackedScene:
	if is_inventory_empty(): return
	return inventory[index]


func get_inventory_size() -> int:
	return inventory.size()


func is_inventory_full() -> bool:
	return inventory.size() >= max_inventory_size


func is_inventory_empty() -> bool:
	return inventory.size() <= 0
