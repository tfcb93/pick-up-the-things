extends CanvasLayer

var buttonChildren;
var buttonTreeIndex := 0;
var actualButton: Button;
var buttonChildrenSize: int;

func _ready() -> void:
	buttonChildren = $VBoxContainer/ButtonContainer.get_children();
	buttonChildrenSize = buttonChildren.size();
	actualButton = buttonChildren[buttonTreeIndex];
	actualButton.grab_focus();

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_forward"):
		buttonTreeIndex = changeFocusIndex(-1);
		actualButton = buttonChildren[buttonTreeIndex];
	if event.is_action_pressed("move_back"):
		buttonTreeIndex = changeFocusIndex(1);
		actualButton = buttonChildren[buttonTreeIndex]
	if event.is_action_pressed("action"):
		print(actualButton);
		


func _on_start_button_pressed() -> void:
	print("Press start");


func _on_settings_button_pressed() -> void:
	print("Press settings");


func _on_exit_button_pressed() -> void:
	print("Press exit");

func changeFocusIndex(val) -> int:
	if (buttonTreeIndex + val > buttonChildrenSize - 1):
		return 0;
	elif (buttonTreeIndex + val < 0):
		return buttonChildrenSize - 1;
	else:
		return buttonTreeIndex + val;
