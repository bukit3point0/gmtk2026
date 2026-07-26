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

var needs_reset := false
var step_1_started := false
var step_2_started := false
var step_3_started := false
var nav_switch_flips: int = 0
var temp_switch_flips: int = 0
var esa_1_switch_flipped := false
var esa_2_switch_flipped_times := 0
var conducting_temp_test: bool = false
var blink_light_5 := false
var blink_lights := false
var light_5_blinking := false
var lights_blinking := false
const NAV_PROTOCOL_START = 3
const TEMP_PROTOCOL_START = 6
const ESA_PROTOCOL_START = 3

func _ready() -> void:
	pass

func _process(_delta) -> void:
	if blink_light_5 and !light_5_blinking:
		blink_light_slowly()
	if blink_lights and !lights_blinking:
		blink_lights_slowly()

func set_initial_switches(switches_array: Array[bool]) -> void:
	switches_on = switches_array
	var any_lights_on = switches_on.filter(func (obj): return true).size()
	if any_lights_on > 0:
		needs_reset = true

func set_step_results(nsc_1, esa_3, final) -> void:
	nsc_1_result = nsc_1
	esa_3_result = esa_3 
	final_step_result = final

func _on_switch_button_pressed(button_index) -> void:
	if step_2_started and TEMP_PROTOCOL_START == temp_switch_flips:
		step_3_started = true
	if step_1_started and NAV_PROTOCOL_START == nav_switch_flips:
		step_2_started = true
	step_1_started = true
	if button_index == 4 and step_1_started: # nav test
		nav_switch_flips += 1
		if NAV_PROTOCOL_START == nav_switch_flips:
			nav_test()
			nav_switch_flips = 0
	
	if button_index == 2 and step_2_started: # temp test also don't start til test 1 done
		temp_switch_flips += 1
		if TEMP_PROTOCOL_START == temp_switch_flips:
			temp_test()
			temp_switch_flips = 0
	
	if button_index == 0 and step_3_started and !esa_1_switch_flipped and esa_2_switch_flipped_times == 0: # first two steps done
		esa_1_switch_flipped = true
	
	if button_index == 1 and step_3_started and esa_1_switch_flipped: # first two steps done
		esa_2_switch_flipped_times += 1
		if ESA_PROTOCOL_START == esa_2_switch_flipped_times:
			esa_test()
			esa_1_switch_flipped = false
			esa_2_switch_flipped_times = 0

	switches_on[button_index] = !switches_on[button_index]

	$LightSwitch.play()
	
	if switches_on[button_index]:
		switches[button_index].texture = switch_on
	else:
		switches[button_index].texture = switch_off

func nav_test():
	EventBus._print_message.emit("Navigation System Control (NSc1) test initiated.")
	if nsc_1_result == ShipProblems.NSc1TestResult.PASS:
		var pass_type = randi_range(0, 1)
		if pass_type == 0:
			lights[4].texture = lit_bulb
		else:
			blink_light_5 = true
	else:
		blink_light_5 = [true, false].pick_random()
		if blink_light_5:
			EventBus._print_message.emit("Warning - Ports 3 and 4 have been labeled incorrectly please swap the labels. The pilot will need to compensate by reversing Y Axis controls.” Proceed to Step 3.")

func blink_light_slowly():
	light_5_blinking = true
	lights[4].texture = lit_bulb
	await get_tree().create_timer(0.5).timeout
	lights[4].texture = lit_bulb
	await get_tree().create_timer(0.5).timeout
	light_5_blinking = false

func blink_lights_slowly():
	lights_blinking = true
	lights[1].texture = lit_bulb
	lights[2].texture = lit_bulb
	await get_tree().create_timer(0.5).timeout
	lights[1].texture = lit_bulb
	lights[2].texture = lit_bulb
	await get_tree().create_timer(0.5).timeout
	lights_blinking = false
	

func temp_test():
	conducting_temp_test = true
	lights[2].texture = lit_bulb
	EventBus._print_message.emit("Beginning External Sensor Array Switch test protocol")

	if esa_3_result == ShipProblems.TestResult.FAIL:
		EventBus._set_temp.emit(0.5)
		if get_tree() != null:
			await get_tree().create_timer(3.0).timeout
			EventBus._set_temp.emit(0)
	elif esa_3_result == ShipProblems.TestResult.WARN:
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
	elif esa_3_result == ShipProblems.TestResult.PASS:
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

func esa_test():
	if final_step_result == ShipProblems.TestResult.FAIL:
		lights[0].texture = lit_bulb
		lights[4].texture = lit_bulb
		blink_lights = true
	if final_step_result == ShipProblems.TestResult.WARN:
		lights[0].texture = lit_bulb
		lights[4].texture = lit_bulb
		EventBus._print_message.emit("Warning the fuel tank is in contact with a deck plate.")

func _on_reset_button_pressed() -> void:
	switches_on = [false, false, false, false, false]
	step_1_started = false
	step_2_started = false
	step_3_started = false
	conducting_temp_test = false
	EventBus._print_message.emit("Lights protocol reset")
	esa_1_switch_flipped = false
	esa_2_switch_flipped_times = 0
