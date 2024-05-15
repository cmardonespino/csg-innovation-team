[{
	"name": "app",
	"image": "httpd:2.4",
	"networkMode": "awsvpc",
	"essential": true,
	"portMappings": [{
	"containerPort": 80,
	"hostPort": 80
	}]
}]