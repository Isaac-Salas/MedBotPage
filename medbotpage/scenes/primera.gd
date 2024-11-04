extends Control
@onready var register = $Register
@onready var login = $Login
@onready var test = $Test
@onready var contra = $Contra
@onready var correo = $Correo
@onready var rich_text_label = $RichTextLabel
var SEGUNDA = load("res://scenes/Segunda/Segunda.tscn")
@export var autolog : bool = false
var firestore_collection : FirestoreCollection
@onready var next : Button = $Next

func _ready():
	#Firebase.Auth.load_auth()
	match autolog:
		true:
			correo.text = "iscprepa@gmail.com"
			contra.text = "123456"
	Firebase.Auth.login_succeeded.connect(_on_FirebaseAuth_login_succeeded)
	Firebase.Auth.signup_succeeded.connect(_on_FirebaseAuth_register_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_failed.connect(on_signup_failed)

func _on_login_pressed():
	
	var email = correo.text
	var password = contra.text
	Firebase.Auth.login_with_email_and_password(email, password)

func _on_register_pressed():
	var email = correo.text
	var password = contra.text
	Firebase.Auth.signup_with_email_and_password(email, password)
	

func _on_FirebaseAuth_login_succeeded(auth):
		# You do not need to call get_user_data() here, as auth is the same variable
	#print(auth)
	Firebase.Auth.save_auth(auth)
	next.visible = true
	next.disabled = false
	
	
	

func _on_FirebaseAuth_register_succeeded(auth):
		# You do not need to call get_user_data() here, as auth is the same variable
	#print(auth)
	Firebase.Auth.save_auth(auth)
	next.visible = true
	next.disabled = false
	#get_tree().change_scene_to_packed(SEGUNDA)
	
func on_login_failed(error_code, message):
	print("error code: " + str(error_code))
	print("message: " + str(message))

func on_signup_failed(error_code, message):
	print("error code: " + str(error_code))
	print("message: " + str(message))


func _on_test_pressed():
	Firebase.Auth.check_auth_file()
	var firestore_collection2 :FirestoreCollection = Firebase.Firestore.collection('medicamento')
	await firestore_collection2.add("", {'name': 'Document Name', 'active': 'true'})


func _on_next_pressed():
	get_tree().change_scene_to_packed(SEGUNDA)
