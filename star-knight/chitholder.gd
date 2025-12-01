extends Control

@export var chitlabel : RichTextLabel
var chits
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	chits = PlayerVar.chits
	PlayerVar.connect("getchits", gainchits)
	PlayerVar.connect("losechits", lostchits)
	PlayerVar.connect("chitchange", setchits)
	setchits()



func gainchits():
	PlayerVar.chits += 50
	setchits()

func lostchits():
	PlayerVar.chits -= 50
	setchits()

func setchits():
	chits = PlayerVar.chits
	chitlabel.set_text(str(chits) + (" Chits"))