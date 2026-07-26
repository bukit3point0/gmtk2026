extends Node2D

@onready var lightbulb_1: TextureRect = $GridContainer/Lightbulb
@onready var lightbulb_2: TextureRect = $GridContainer/Lightbulb2
@onready var lightbulb_3: TextureRect = $GridContainer/Lightbulb3
@onready var lightbulb_4: TextureRect = $GridContainer/Lightbulb4
@onready var lightbulb_5: TextureRect = $GridContainer/Lightbulb5
@onready var switch_1: TextureRect = $GridContainer/Switch
@onready var switch_2: TextureRect = $GridContainer/Switch2
@onready var switch_3: TextureRect = $GridContainer/Switch3
@onready var switch_4: TextureRect = $GridContainer/Switch4
@onready var switch_5: TextureRect = $GridContainer/Switch5

@onready var lights: Array[TextureRect] = [lightbulb_1, lightbulb_2, lightbulb_3, lightbulb_4, lightbulb_5]
@onready var switches: Array[TextureRect] = [switch_1, switch_2, switch_3, switch_4, switch_5]

var unlit_bulb = preload("uid://ctl34c38murvo")
var lit_bulb = preload("uid://den8akhwdtr4x")
var switch_on = preload("uid://bcigmnpnb71u1")
var switch_off = preload("uid://djdavkyeuyedt")

var switches_on = [false, false, false, false, false]

var temperature_test = ShipProblems.TestResult.FAIL
var temp_switch_flips: int = 0
const TEMP_PROTOCOL_START = 6

func _ready() -> void:
	pass

func _on_switch_button_pressed(button_index) -> void:
	print("button pressed")
	print(button_index)

	if button_index == 2: # temp test
		temp_switch_flips += 1
		if TEMP_PROTOCOL_START == temp_switch_flips:
			lights[button_index].texture = lit_bulb
			temp_switch_flips = 0
			EventBus._print_message.emit("Beginning External Sensor Array Switch test protocol")

	switches_on[button_index] = !switches_on[button_index]

	if switches_on[button_index]:
		switches[button_index].texture = switch_on
	else:
		switches[button_index].texture = switch_off
