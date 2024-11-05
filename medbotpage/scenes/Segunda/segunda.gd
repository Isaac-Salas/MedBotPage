extends Control
@onready var rich_text_label = $RichTextLabel
@onready var selected : String
@onready var item_list = $ItemList
@onready var input : TextEdit= $Input
@export var info : Array 
@onready var canselect : bool = false
@onready var mensajeinit : String
@onready var label = $Label
@onready var HTMLTEST = load("res://scenes/testing/HTMLTEST.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	var ass = Firebase.Auth.check_auth_file()
	rich_text_label.append_text(str("Logged: ", ass))
	mensajeinit = input.placeholder_text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_send_pressed():
	if canselect == true:
		var firestore_collection : FirestoreCollection = Firebase.Firestore.collection(selected)
		var data : Dictionary = {}
		var current : int = 0
		for i in info.size():
			var text : String = input.get_line(current)
			data.merge({info[current]: text})
			current += 1
		print(data)
		await firestore_collection.add("",data)
	else:
		print("Selecciona el Documento deseado")


func _on_item_list_item_selected(index):
	var count : int = 0
	canselect =  true
	match index:
		0:
			selected = "interaciones"
		1:
			selected = "medicamento"
			info = ["Nombre", "Descripcion", "Sintomas", "Dosis_recomendada", "Efectos_Secundarios", "Restricciones", "Creado_En", "Actualizado_En"]
		2:
			selected = "notificaciones"
		3:
			selected = "reseta"
	
	label.text = ""
	input.clear()
	input.placeholder_text = str("Para ",selected, " escribe lo siguiente:\n")
	label.text = "RECUERDA ES:...\n"
	for i in info.size():
		input.placeholder_text += str("\n-",info[count])
		label.text += str("\n-",info[count])
		count += 1
	print(selected)
	
	


func _on_clear_pressed():
	input.clear()
	item_list.deselect_all()
	input.placeholder_text = mensajeinit
	get_tree().change_scene_to_packed(HTMLTEST)
