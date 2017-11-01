extends Node

var timer         = null
var timerLabel    = null
var seconds       = 0
var attackVal     = null
var attackMod     = null
var attackTarg    = null
var fightButton   = null
var difficulty    = 1
var base          = 10

var cardOne       = null
var cardTwo       = null
var cardThree     = null
var cardOptions   = [1,2,3,4,5,6,7,8,9,10]

var plus          = null
var minus         = null
var divide        = null
var multiply      = null

var enemyHP       = null
var playerHP      = null

func _ready():
	timerLabel    = get_node("TimerLabel");
	timer         = get_node("Timer");
	fightButton   = get_node("Fight");
	attackVal     = get_node("AttackValue");
	attackMod     = get_node("AttackMod");
	attackTarg    = get_node("AttackTarget");
	cardOne       = get_node("CardOne");
	cardTwo       = get_node("CardTwo");
	cardThree     = get_node("CardThree");
	plus          = get_node("Plus");
	minus         = get_node("Minus");
	divide        = get_node("Divide");
	multiply      = get_node("Multiply");
	enemyHP       = get_node("EnemyHP");
	playerHP      = get_node("PlayerHP");
	
	# Config timer
	timer.connect("timeout", self, "_on_timer_tick");
	timer.set_wait_time(1);
	
	# Button listeners
	fightButton.connect("pressed", self, "_on_fight_button_clicked")
	cardOne.connect("pressed", self, "_on_card_one_button_clicked")
	cardTwo.connect("pressed", self, "_on_card_two_button_clicked")
	cardThree.connect("pressed", self, "_on_card_three_button_clicked")
	plus.connect("pressed", self, "_on_mod_button_clicked", ["+"])
	minus.connect("pressed", self, "_on_mod_button_clicked", ["-"])
	multiply.connect("pressed", self, "_on_mod_button_clicked", ["x"])
	divide.connect("pressed", self, "_on_mod_button_clicked", ["/"])
	
func _on_mod_button_clicked(action):
	attackMod.set_text(action);
	cardOne.show();
	cardTwo.show();
	cardThree.show();
	plus.hide();
	minus.hide();
	multiply.hide();
	divide.hide();
	
func _on_card_one_button_clicked():
	if attackVal.get_text() == "":
		attackVal.set_text(cardOne.get_node("Label").get_text());
	else:
		if attackMod.get_text() == '+':
			attackVal.set_text(str(int(attackVal.get_text()) + int(cardOne.get_node("Label").get_text())))
		elif attackMod.get_text() == '-':
			attackVal.set_text(str(int(attackVal.get_text()) - int(cardOne.get_node("Label").get_text())))
		elif attackMod.get_text() == 'x':
			attackVal.set_text(str(int(attackVal.get_text()) * int(cardOne.get_node("Label").get_text())))
		elif attackMod.get_text() == '/':
			attackVal.set_text(str(int(attackVal.get_text()) / int(cardOne.get_node("Label").get_text())))
		attackMod.set_text("")
	cardOne.get_node("Label").set_text(_get_next_card());
	cardOne.hide();
	cardTwo.hide();
	cardThree.hide();
	plus.show();
	minus.show();
	multiply.show();
	divide.show();
	if int(attackVal.get_text()) >= int(attackTarg.get_text()):
		enemyHP.set_text(str(int(enemyHP.get_text()) - 1))
		_reset()
	
func _on_card_two_button_clicked():
	if attackVal.get_text() == "":
		attackVal.set_text(cardTwo.get_node("Label").get_text());
	else:
		if attackMod.get_text() == '+':
			attackVal.set_text(str(int(attackVal.get_text()) + int(cardTwo.get_node("Label").get_text())))
		elif attackMod.get_text() == '-':
			attackVal.set_text(str(int(attackVal.get_text()) - int(cardTwo.get_node("Label").get_text())))
		elif attackMod.get_text() == 'x':
			attackVal.set_text(str(int(attackVal.get_text()) * int(cardTwo.get_node("Label").get_text())))
		elif attackMod.get_text() == '/':
			attackVal.set_text(str(int(attackVal.get_text()) / int(cardTwo.get_node("Label").get_text())))
		attackMod.set_text("")
	cardTwo.get_node("Label").set_text(_get_next_card());
	cardOne.hide();
	cardTwo.hide();
	cardThree.hide();
	plus.show();
	minus.show();
	multiply.show();
	divide.show();
	if int(attackVal.get_text()) >= int(attackTarg.get_text()):
		enemyHP.set_text(str(int(enemyHP.get_text()) - 1))
		_reset()
	
func _on_card_three_button_clicked():
	if attackVal.get_text() == "":
		attackVal.set_text(cardThree.get_node("Label").get_text());
	else:
		if attackMod.get_text() == '+':
			attackVal.set_text(str(int(attackVal.get_text()) + int(cardThree.get_node("Label").get_text())))
		elif attackMod.get_text() == '-':
			attackVal.set_text(str(int(attackVal.get_text()) - int(cardThree.get_node("Label").get_text())))
		elif attackMod.get_text() == 'x':
			attackVal.set_text(str(int(attackVal.get_text()) * int(cardThree.get_node("Label").get_text())))
		elif attackMod.get_text() == '/':
			attackVal.set_text(str(int(attackVal.get_text()) / int(cardThree.get_node("Label").get_text())))
		attackMod.set_text("")
	cardThree.get_node("Label").set_text(_get_next_card());
	cardOne.hide();
	cardTwo.hide();
	cardThree.hide();
	plus.show();
	minus.show();
	multiply.show();
	divide.show();
	if int(attackVal.get_text()) >= int(attackTarg.get_text()):
		enemyHP.set_text(str(int(enemyHP.get_text()) - 1))
		_reset()
	
func _reset():
	attackVal.set_text("")
	attackMod.set_text("")
	attackTarg.set_text("")
	cardOne.hide();
	cardTwo.hide();
	cardThree.hide();
	plus.hide();
	minus.hide();
	multiply.hide();
	divide.hide();
	fightButton.show();
	timer.stop();
	seconds = 0
	_set_timer_label()
	
func _on_timer_tick():
	if seconds > 0:
		seconds = seconds - 1
		_set_timer_label();
	else:
		playerHP.set_text(str(int(playerHP.get_text()) - 1))
		_reset();
	
func _set_timer_label():
	var timerString = "";
	var minutes     = seconds / 60;
	var remainder   = seconds % 60;
	if remainder == 0:
		remainder = "00"
	elif remainder < 10:
		remainder = "0"+str(remainder)
	timerLabel.set_text(str(minutes) + ":" + str(remainder));
	
func _on_fight_button_clicked():
	fightButton.hide();
	_set_attack_value();
	randomize();
	cardOne.get_node("Label").set_text(_get_next_card());
	cardTwo.get_node("Label").set_text(_get_next_card());
	cardThree.get_node("Label").set_text(_get_next_card());
	cardOne.show();
	cardTwo.show();
	cardThree.show();
	seconds = 30;
	_set_timer_label();
	timer.start();
	
func _get_next_card():
	if cardOptions.size() == 0:
		cardOptions = [1,2,3,4,5,6,7,8,9,10]
		
	var item = randi() % cardOptions.size()
	var val  = str(cardOptions[item])
	cardOptions.remove(item)
		
	return val
	
func _set_attack_value():
	randomize();
	var top_base    = base*(difficulty*10)
	var bottom_base = top_base/10
	attackTarg.set_text(str(int(rand_range(bottom_base, top_base))))