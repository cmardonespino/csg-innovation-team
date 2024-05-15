[{
	"name": "app",
	"image": "rancher/hello-world",
	"networkMode": "awsvpc",
	"essential": true,
	"portMappings": [{
	"containerPort": 80,
	"hostPort": 80
	}]
}]