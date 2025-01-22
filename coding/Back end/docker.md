![[0_mOtYeWRK_MwO0riE.webp]]
### **Benefits of Containerization**
1. Portability across environments.
2. Scalability for workload demands(Flexibility for microservices architectures.).
3. Process-level isolation 
4. Consistency and reproducibility.
5. Faster deployment and start-up.
6. Resource efficiency compared to VMs.
7. Improved development and testing environments.
8. Simplified CI/CD pipelines.
9. Enhanced security through isolation.
10. Easy collaboration via container registries.
12. Cost savings through better resource utilization.
13. lightweight

A **container**: is a lightweight, standalone, and executable software package that includes everything needed to run an application: code, runtime, libraries, and dependencies. Containers isolate applications from the underlying system, ensuring consistency across different environments (e.g., development, testing, production). They use the host operating system's kernel, making them more efficient and faster to start than traditional virtual machines. Popular tools for managing containers include Docker and Kubernetes.

### image 
**image** is a lightweight, stand-alone, and executable package that includes everything needed to run a piece of software, including:
- **Code** (e.g., application code or binaries)
- **Runtime environment** (e.g., .NET runtime, Java runtime, etc.)
- **Libraries and dependencies** required by the application
- **Configuration files** (e.g., environment variables, system settings)
- **File system** for the application to run
# Commands
### **Docker Commands**

#### **1. Docker Run**

Run a container from an image.

```bash
docker run <image_name>
docker run --name <container_name> <image_name>


docker run --detach <image_name>     -to run in backgrund mode
```

#### **2. Docker Pull**

Pull an image from Docker Hub.

```bash
docker pull <image_name>
docker pull <image_name:tag>
```

#### **3. Docker PS**

List containers.

```bash
docker ps               # Running containers
docker ps -a            # All containers
docker ps -l            # Last created container
docker ps -q            # Container IDs only
```

#### **4. Docker Stop**

Stop a running container.

```bash
docker stop <container_ID>
docker stop container1 container2 container3  # Multiple containers
```

#### **5. Docker Start**

Start a stopped container.

```bash
docker start <container_ID>
```

#### **6. Docker RM**

Remove containers.

```bash
docker rm <container_name_or_ID>
docker rm -f <container_name_or_ID>          # Force removal
docker rm -v <container_name_or_ID>          # Remove with volumes
```

#### **7. Docker RMI**

Remove images.

```bash
docker rmi <image_name_or_ID>
```

#### **8. Docker Images**

List all images in the system.

```bash
docker images
```

#### **9. Docker Exec**

Run a command in a running container.

```bash
docker exec {options} <container_name_or_ID> <command>
docker exec -it <container_name_or_ID> /bin/bash  # Interactive terminal
```

#### **10. Docker Ports**

Map host ports to container ports.

```bash
docker run -d -p <host_port>:<container_port> <image_name>
```

#### **11. Docker Login**

Authenticate with Docker Hub.

```bash
docker login
```

#### **12. Docker Push**

Push an image to Docker Hub.

```bash
docker push <image_name:tag>
```

#### **13. Docker Build**

Build an image from a Dockerfile.

```bash
docker build -t <image_name:tag> .
```

#### **14. Docker Restart**

Restart a container.

```bash
docker restart <container_name_or_ID>
```

#### **15. Docker Inspect**

View detailed information about a container.

```bash
docker inspect <container_name_or_ID>
```

#### **16. Docker Commit**

Create a new image from a container.

```bash
docker commit <container_name_or_ID> <new_image_name:tag>
```
#### **17. Docker Stats
Get resource usage statistics like CPU %, memory, etc. for a container.

```bash
 docker stats  <container_name_or_ID> 
```
#### **18. Docker Rename**

Rename an existing container.
``` bash

docker rename <container_ID> <new_container_name> 

docker rename <current_container_name> <new_container_name>


```



# port 
A **port** in networking and computing is a logical endpoint used for communication between devices over a network. In the context of Docker and containers, ports allow applications inside containers to communicate with the outside world or other containers. Here's a breakdown:

 **Port in Docker:**
In Docker, ports are used to map the container's internal network to the host machine's network. When running a container, you can expose specific ports so that the container can communicate with the outside world (or with other containers) through those ports.

