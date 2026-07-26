class_name ShipProblems
extends Resource

enum TestResult { PASS, WARN, FAIL }
enum NSc1TestResult { PASS, WARN }
enum LightsTestResult { PASS, CRIT, WARN }

@export_multiline var stopped_bad_rocket: String
@export_multiline var stopped_good_rocket: String
@export_multiline var launched_bad_rocket: String
@export_multiline var launched_good_rocket: String

@export var condition: int

@export var temperature_test: TestResult
@export var ship_plate_id: String
@export var wires_test: TestResult
@export var wires_array: Array[int]

# four steps for lights
@export var switches_on: Array[bool]
@export var nsc1: NSc1TestResult
@export var esa3: LightsTestResult
@export var final: LightsTestResult
