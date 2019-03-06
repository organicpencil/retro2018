extends Label

var lapsed = 0
var charNum = 0
var label1
var labelcounter 

func _ready():
	lapsed = 0
	visible_characters = 0
	labelcounter = $Label1
	
	print(label1)
	
func _process(delta):
	label1 = labelcounter.get_total_character_count()
	lapsed = lapsed + delta
	charNum = labelcounter.set_visible_characters(lapsed / .1)
	if labelcounter.get_visible_characters() >= label1:
		showchar($Label2)
	
	
func showchar(label):
	
	lapsed = 0;
	labelcounter = label
	pass