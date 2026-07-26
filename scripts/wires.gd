extends Node2D

@onready var wire_1_red: Node2D = $Wire1Red
@onready var wire_2_blue: Node2D = $Wire2Blue
@onready var wire_1_yellow: Node2D = $Wire1Yellow
@onready var wire_1_green: Node2D = $Wire1Green
@onready var wire_1_purple: Node2D = $Wire1Purple
@onready var wire_1_black: Node2D = $Wire1Black


func update_wires(wire_selection: Array) -> void:
	print("wire")
	wire_1_red.get_child(wire_selection[0]).visible = true
	wire_2_blue.get_child(wire_selection[1]).visible = true
	wire_1_yellow.get_child(wire_selection[2]).visible = true
	wire_1_green.get_child(wire_selection[3]).visible = true
	wire_1_purple.get_child(wire_selection[4]).visible = true
	wire_1_black.get_child(wire_selection[5]).visible = true
	

func _on_button_pressed() -> void:
	print("click")

func _on_wire_length_1_pressed() -> void:
	print("click2")
