# docker-crash-course
course-work for The Net Ninja Docker Course

# Docker Notes

## Images & containers

- to show all available images
  ```
  command: docker images
  ```
- to show all running containers
  ```
  command: docker ps
  ```
- to show all containers **_(both running and stopped)_**
  ```
  command: docker ps -a
  ```
- build an image from a Dockerfile

  ```
  command: docker build -t <image_name:tag_name> (relative path of your Dockerfile)

  eg: docker build -t myapp .
  ```

- build and run a contianer from an exisiting image

  ```
  command: docker run --name <container_name> -p <local_machine_port:container_port> -d<for daemon mode> <image_name>
  eg: docker run --name myapp_c1 -p 3000:4000 -d myapp
  ```

  - the above commands create a container named `myapp_c1` from image named `myapp` and maps port `3000` from **_host machine_** to port `4000` of **_container_** and also runs the process in daemon mode so that it will not block your console

- stop a container

  ```
  command: docker stop <container_name|id>

  eg: docker stop myapp_c1
  ```

- start a container

  ```
  command: docker start <container_name|id>

  eg: docker start myapp_c1
  ```

- to remove an unused image

  ```
  command: docker image rm <image_name|id>

  eg: docker image rm myapp
  ```

  - please note this command will return error if the image is being used by any container

- to forcefully remove an image **_even if it is being used_**

  ```
  command: docker image rm <image_name|id> -f

  eg: docker image rm myapp -f
  ```

- to delete 1 or more containers

  ```
  command: docker container rm <container1_name|id> <container2_name|id>  ..... <containern_name|id>

  eg: docker container rm myapp_c1 myapp_c2
  ```

- **DANGER** deleting all images, volumes and containers in your system

  ```
  command: docker system prune -a
  ```

- **providing versions to your images:** in docker tags are used to version your images

  ```
  eg: docker build -t myapp:v1 .
  ```

  - images generated in docker are **immutable** that is readonly only it state cannot be changed once build.

## Docker Volumes

### theory:

- Volumes is a feature in Docker that allows certain folders of your host_machine be available to the container
- This can prove useful when developing the project as re-building the images again and again is a painful job
- Volumes gave us a way to map directories b/w our host_computer and container

### commands:

- **providing volumes to your images:**

  ```
  command: docker run --name <container_name> -p <local_machine_port:container_port> -v<absolute path for your host_machine : relative path of your container> -d<for daemon mode> <image_name>

  eg: docker run --name myapp_c1 -p 3000:4000 -v /home/users/documents/api:/app --rm myapp
  ```

- anonymous volume to your container
  ```
  eg: docker run --name myapp_c1 -p 3000:4000 -v /home/users/documents/api:/app -v ./app/node_modules --rm myapp
  ```

## Docker Compose

### theory:

- Docker Compose gives us a way to create a single `docker-compose.yaml` file which contains all the configuration which is required to run multiple projects.
- this avoids hassle of running multiple commands for each project
- create a `docker-compose.yaml` in the root directory of your project.
- sample docker compose file
  ```
  version:"3.8"
  services:
    api:
        build: ./api # relative path to Dockerfile to build the service
        container_name: myapp_c1 # name of your container
        ports:
            - "3000:4000" # port mapping
        volumes:
            - ./api:/app # giving volumes information relative path are only needed
            - ./app/node_modules
  ```
- `docker-compose` command does 2 tasks:
  - it will create call all the services build commands.
  - then, according to the sevice configuration it will start the containers with relevant port-mapping and volumes.

### commands:

- run the project using docker-compose
  ```
  command: docker-compose up
  ```
- stop the project
  ```
  commmand: docker-compose down
  ```
  - this command stop the containers created and removes them but images and volumes will remain as it is.
- to remove even the images and volumes
  ```
  command: docker-compose down --rmi all -v
  ```
