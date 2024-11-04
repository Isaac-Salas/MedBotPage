extends Control
@onready var rich_text_label = $RichTextLabel
@onready var selected : String
@onready var item_list = $ItemList
@onready var input : TextEdit= $Input
@export var info : Array 
@onready var canselect : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	var ass = Firebase.Auth.check_auth_file()
	rich_text_label.append_text(str("Logged: ", ass))


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
	var count
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
			
	for i in info.size():
		pass
	print(selected)
	
	


func _on_clear_pressed():
	pass # Replace with function body.
