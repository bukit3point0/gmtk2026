extends Node2D

@onready var lightbulb: TextureRect = $GridContainer/Lightbulb
@onready var lightbulb_2: TextureRect = $GridContainer/Lightbulb2
@onready var lightbulb_3: TextureRect = $GridContainer/Lightbulb3
@onready var lightbulb_4: TextureRect = $GridContainer/Lightbulb4
@onready var lightbulb_5: TextureRect = $GridContainer/Lightbulb5
@onready var switch: TextureRect = $GridContainer/Switch
@onready var switch_2: TextureRect = $GridContainer/Switch2
@onready var switch_3: TextureRect = $GridContainer/Switch3
@onready var switch_4: TextureRect = $GridContainer/Switch4
@onready var switch_5: TextureRect = $GridContainer/Switch5

var switches_on = [false, false, false, false, false]

func _ready() -> void:
	update_lights()

func update_lights() -> void:
	turn_light_on(lightbulb, switch, switches_on[0])
	turn_light_on(lightbulb_2, switch_2, switches_on[1])
	turn_light_on(lightbulb_3, switch_3, switches_on[2])
	turn_light_on(lightbulb_4, switch_4, switches_on[3])
	turn_light_on(lightbulb_5, switch_5, switches_on[4])

func turn_light_on(lightbulb: TextureRect, switch: TextureRect, on: bool = true) -> void:
	var unlit_bulb = preload("uid://ctl34c38murvo")
	var lit_bulb = preload("uid://den8akhwdtr4x")
	var switch_off = preload("uid://bcigmnpnb71u1")
	var switch_on = preload("uid://djdavkyeuyedt")
	
	lightbulb.texture = lit_bulb if on else unlit_bulb
	switch.texture = switch_on if on else switch_off

func _on_switch_1_pressed() -> void:
	switches_on[0] = !switches_on[0]
	update_lights()

func _on_switch_2_pressed() -> void:
	switches_on[1] = !switches_on[1]
	update_lights()

func _on_switch_3_pressed() -> void:
	switches_on[2] = !switches_on[2]
	update_lights()

func _on_switch_4_pressed() -> void:
	switches_on[3] = !switches_on[3]
	update_lights()

func _on_switch_5_pressed() -> void:
	switches_on[4] = !switches_on[4]
	update_lights()
