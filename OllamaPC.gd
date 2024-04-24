extends Area2D

var http_request: HTTPRequest
const URL: String = "http://127.0.0.1:11434/api/generate"
var text_now: String = ""
var show_text: bool = false
var REQUEST_BASE: Dictionary = {"model": "MistralPC", "stream": false}

# Called when the node enters the scene tree for the first time.
func _ready():
	var dic = {}
	dic["one"] = 1
	dic["prompt"] = "something"
	print("dic", dic)
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._on_request_completed)
	var body = JSON.stringify(REQUEST_BASE)
	var error = http_request.request(URL, [], HTTPClient.METHOD_POST, body)
	assert(error == OK, "ERROR: No connection to Ollama!")

	get_node("AnimatedSprite2D").play("default")

func _on_request_completed(result, response_code, headers, body):
	print("REQUEST COMPLETE!")
	var json = JSON.parse_string(body.get_string_from_utf8())
	text_now = json.get("response", "")
	print(json)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_talk():
	text_now = "..."
	show_text = true
	get_node("AnimatedSprite2D").play("talk")
	var request = REQUEST_BASE
	print(request)
	print(request["prompt"])
	request["prompt"] = "talk"
	print(request)
	var body = JSON.stringify(request)
	http_request.request(URL, [], HTTPClient.METHOD_POST, body)
