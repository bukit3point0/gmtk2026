class_name ShipProblems
extends Resource

enum TestResult { PASS, WARN, FAIL }

@export_multiline var stopped_bad_rocket: String
@export_multiline var stopped_good_rocket: String
@export_multiline var launched_bad_rocket: String
@export_multiline var launched_good_rocket: String

@export var condition: int

@export var temperature_test: TestResult