# build docker image from Dockerfile -t is tag given to image . is the location of the Dockerfile
docker build -t demo-node-api .

# run docker container from the image --name is used to give container name 
# => this command first creates a container and then runs it
docker run --name myapp_c1 demo-node-api

# show list of all running containers
docker ps
# use -a to show all available containers
docker ps -a

# show all available images
docker images

# stop a particular container
docker stop myapp_c1

# start an exisiting container
docker start myapp_c1

# run adocker container by exposing port on local machine and in detach mode
# -d for detachh mode = does not block console
# -p for port mapping local_port:container_port
# --name for naming your container
docker run --name myapp_c2 -p 4000:4000 -d demo-node-api