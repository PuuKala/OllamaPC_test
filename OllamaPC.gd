extends Area2D

var http_request
const URL = "http://127.0.0.1:11434/api/generate"
var ollama_context = []

# Called when the node enters the scene tree for the first time.
func _ready():
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._on_request_completed)
	var body = JSON.stringify({"model": "qwen:0.5b"})
	http_request.request(URL, [], HTTPClient.METHOD_POST, body)
	get_node("AnimatedSprite2D").play("default")

func _on_request_completed(result, response_code, headers, body):
	print("REQUEST COMPLETE!")
	var json = JSON.parse_string(body.get_string_from_utf8())
	print(json)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_talk():
	var body = JSON.stringify({	"model": "qwen:0.5b",
								"prompt": "Why is the sky blue?",
								"stream": false})
	http_request.request(URL, [], HTTPClient.METHOD_POST, body)
	pass # Replace with function body.
