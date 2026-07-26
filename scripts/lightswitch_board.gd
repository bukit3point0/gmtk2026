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
var switch_on = preload("uid://bsdacw00b0gem")
var switch_off = preload("uid://lp42ulfjx0cx")

var switches_on = [false, false, false, false, false]
var nsc_1_result
var esa_3_result
var final_step_result

var temperature_test = ShipProblems.TestResult.PASS
var temp_switch_flips: int = 0
var conducting_temp_test: bool = false
const TEMP_PROTOCOL_START = 6

func _ready() -> void:
	pass

func set_initial_switches(switches_array: Array[bool]) -> void:
	switches_on = switches_array

func set_step_results(nsc_1, esa_3, final) -> void:
	nsc_1_result = nsc_1
	esa_3_result = esa_3 
	final_step_result = final

func _on_switch_button_pressed(button_index) -> void:
	if button_index == 2: # temp test
		temp_switch_flips += 1
		if TEMP_PROTOCOL_START == temp_switch_flips:
			temp_test()
			temp_switch_flips = 0

	switches_on[button_index] = !switches_on[button_index]

	$LightSwitch.play()
	
	if switches_on[button_index]:
		switches[button_index].texture = switch_on
	else:
		switches[button_index].texture = switch_off

func temp_test():
	conducting_temp_test = true
	lights[2].texture = lit_bulb
	EventBus._print_message.emit("Beginning External Sensor Array Switch test protocol")

	if temperature_test == ShipProblems.TestResult.FAIL:
		EventBus._set_temp.emit(0.5)
		if get_tree() != null:
			await get_tree().create_timer(3.0).timeout
			EventBus._set_temp.emit(0)
	elif temperature_test == ShipProblems.TestResult.WARN:
		EventBus._set_temp.emit(1)
		if get_tree() != null:
			await get_tree().create_timer(1.0).timeout
		EventBus._set_temp.emit(0.9)
		if get_tree() != null:
			await get_tree().create_timer(2.0).timeout
		EventBus._set_temp.emit(1)
		if get_tree() != null:
			await get_tree().create_timer(0.5).timeout
		EventBus._set_temp.emit(0.6)
		if get_tree() != null:
			await get_tree().create_timer(0.8).timeout
		EventBus._set_temp.emit(1)
		if get_tree() != null:
			await get_tree().create_timer(0.5).timeout
		EventBus._set_temp.emit(0)
	elif temperature_test == ShipProblems.TestResult.PASS:
		EventBus._set_temp.emit(1)
		if get_tree() != null:
			await get_tree().create_timer(3).timeout
		EventBus._set_temp.emit(0.6)
		if get_tree() != null:
			await get_tree().create_timer(1.2).timeout
		EventBus._set_temp.emit(0)
		

	conducting_temp_test = false
	lights[2].texture = unlit_bulb
	EventBus._print_message.emit("External Sensor Array Switch test concluded")
