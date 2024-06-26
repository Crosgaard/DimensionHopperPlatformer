extends Node2D

signal requested_record_set

var http_request : HTTPRequest = HTTPRequest.new()
const SERVER_URL = "http://kwazyddu.dk/db_test.php"
const SERVER_HEADERS = ["Content-Type: application/x-www-form-urlencoded", "Cache-Control: max-age=0"]
const SECRET_KEY = 1234567890
var nonce = null
var request_queue : Array = []
var is_requesting : bool = false

var requested_record: String = "":
	set(value):
		requested_record = value
		requested_record_set.emit()

func _ready():
	randomize()
	add_child(http_request)
	http_request.connect("request_completed", Callable(self, "_http_request_completed"))
	print(await(get_record("Din Mor")))

func _process(delta):
	
	if is_requesting:
		return
		
	if request_queue.is_empty():
		return
		
	is_requesting = true
	
	if nonce == null:
		request_nonce()
	else:
		_send_request(request_queue.pop_front())

func request_nonce():
	var client = HTTPClient.new()
	var data = client.query_string_from_dict({"data" : JSON.stringify({})})
	var body = "command=get_nonce&" + data
	
	var err = http_request.request(SERVER_URL, SERVER_HEADERS, HTTPClient.METHOD_POST, body)
	
	if err != OK:
		printerr("HTTPRequest error: " + String(err))
		return
		
	print("Request nonce")
	
		
func _send_request(request: Dictionary):
	var client = HTTPClient.new()
	var data = client.query_string_from_dict({"data" : JSON.stringify(request['data'])})
	var body = "command=" + request['command'] + "&" + data
	
	var cnonce = str(Crypto.new().generate_random_bytes(32)).sha256_text()
	
	var client_hash = (nonce + cnonce + body + str(SECRET_KEY)).sha256_text()
	print(client_hash)
	nonce = null
	
	var headers = SERVER_HEADERS.duplicate()
	headers.push_back("cnonce: " + cnonce)
	headers.push_back("hash: " + client_hash)
	
	var err = http_request.request(SERVER_URL, headers, HTTPClient.METHOD_POST, body)
		
	if err != OK:
		printerr("HTTPRequest error: " + String(err))
		return
		
	#$TextEdit.set_text(body)
	print("Requesting...\n\tCommand: " + request['command'] + "\n\tBody: " + body)


func _http_request_completed(_result, _response_code, _headers, _body):
	is_requesting = false
	if _result != http_request.RESULT_SUCCESS:
		printerr("Error w/ connection: " + String(_result))
		return
	
	var response_body = _body.get_string_from_utf8()
	#$TextEdit.set_text(response_body)
	var test_json_conv = JSON.new()
	test_json_conv.parse(response_body)
	var response = test_json_conv.get_data()

	if response['error'] != "none":
		printerr("We returned error: " + response['error'])
		return
		
	if response['command'] == "get_nonce":
		nonce = response['response']['nonce']
		print("Get nonce: " + response['response']['nonce'])
		return
	
	if response['command'] == "get_record":
		if response['response']['size'] > 0:
			requested_record = response['response'][str(0)]["record"]

func get_record(username: String):
	request_record(username)
	await(requested_record_set)
	return requested_record

func add_record(username: String = "", record: String = ""):
	if username == "" or username.length() > 40:
		print("Invalid username")
		return
	
	if record == "":
		print("Empty record")
		return
	
	var command = "add_record"
	var data = {"username": username, "record": record}
	request_queue.push_back({"command": command, "data": data})

func request_record(username: String = ""):
	var command = "get_record"
	var data = {"username": username}
	request_queue.push_back({"command": command, "data": data})
