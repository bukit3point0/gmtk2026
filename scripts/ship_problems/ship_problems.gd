class_name ShipProblems
extends Resource

enum TestResult { PASS, WARN, FAIL }

@export var condition: int

@export var temperature_test: TestResult