extends Node

var solution   = null
var problem    = null
var response   = null
var slider     = null
var difficulty = 1
var base       = 10

func _ready():
	set_process(true)
	solution   = get_node("solution")
	problem    = get_node("problem")
	response   = get_node("response")
	slider     = get_node("difficulty")
	slider.connect("value_changed", self, "_on_slider_change")
	get_node("seven")     .connect("pressed", self, "_on_calc_button_clicked", ["7"])
	get_node("four")      .connect("pressed", self, "_on_calc_button_clicked", ["4"])
	get_node("one")       .connect("pressed", self, "_on_calc_button_clicked", ["1"])
	get_node("clear")     .connect("pressed", self, "_on_calc_button_clicked", ["clear"])
	get_node("eight")     .connect("pressed", self, "_on_calc_button_clicked", ["8"])
	get_node("five")      .connect("pressed", self, "_on_calc_button_clicked", ["5"])
	get_node("two")       .connect("pressed", self, "_on_calc_button_clicked", ["2"])
	get_node("zero")      .connect("pressed", self, "_on_calc_button_clicked", ["0"])
	get_node("nine")      .connect("pressed", self, "_on_calc_button_clicked", ["9"])
	get_node("six")       .connect("pressed", self, "_on_calc_button_clicked", ["6"])
	get_node("three")     .connect("pressed", self, "_on_calc_button_clicked", ["3"])
	get_node("back")      .connect("pressed", self, "_on_calc_button_clicked", ["back"])
	get_node("divide")    .connect("pressed", self, "_on_calc_button_clicked", ["/"])
	get_node("left_para") .connect("pressed", self, "_on_calc_button_clicked", ["("])
	get_node("right_para").connect("pressed", self, "_on_calc_button_clicked", [")"])
	get_node("multiply")  .connect("pressed", self, "_on_calc_button_clicked", ["*"])
	get_node("minus")     .connect("pressed", self, "_on_calc_button_clicked", ["-"])
	get_node("add")       .connect("pressed", self, "_on_calc_button_clicked", ["+"])
	get_node("enter")     .connect("pressed", self, "_on_calc_button_clicked", ["enter"])
	_get_new_problem()

func _on_slider_change(value):
	difficulty = value

func _on_calc_button_clicked(buttonText):
	if buttonText == "clear":
		solution.set_text("")
	elif buttonText == "back":
		var text = solution.get_text()
		solution.set_text(text.substr(0, text.length() - 1))
	elif buttonText == "enter":
		_evaluate_win()
	else:
		solution.set_text(solution.get_text()+buttonText)

func _evaluate_win():
		var script = GDScript.new()
		script.set_source_code("func eval():\n\treturn " + solution.get_text())
		script.reload()
		var obj = Reference.new()
		obj.set_script(script)
		var total = obj.eval()
		if int(total) == int(problem.get_text()):
			response.set_text("Congratufuckinglations")
		else:
			response.set_text("Fucking idiot.")

		solution.set_text("")
		_get_new_problem()

func _get_new_problem():
	var top_base    = base*(difficulty*10)
	var bottom_base = top_base/10
	problem.set_text(str(int(rand_range(bottom_base, top_base))))