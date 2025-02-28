# Project Overview

Built and deployed two .NET Microservices using the REST API pattern.

## Details

- Dedicated persistence layers for both services
- Deployed services to a Kubernetes cluster
- Employed the API Gateway pattern for routing
- Implemented synchronous messaging between services using HTTP and gRPC
- Built asynchronous messaging between services using an Event Bus (RabbitMQ)
- IaC and scripting for automated deployment and portability
- Cloud architecture and deployment on infrastructure

## Technologies

- [.NET](https://dotnet.microsoft.com/en-us/)
- [Apache](https://www.apache.org/)
- [AWS](https://aws.amazon.com/)
- [C#](https://learn.microsoft.com/en-us/dotnet/csharp/)
- [curl](https://curl.se/)
- [Docker](https://learn.microsoft.com/en-us/dotnet/csharp/)
- [gRPC](https://grpc.io/)
- [k9s](https://github.com/derailed/k9s?ref=terminaltrove)
- [Kubernetes](https://kubernetes.io/)
- [Kubetui](https://github.com/sarub0b0/kubetui)
- [Lazydocker](https://github.com/jesseduffield/lazydocker)
- [Lazygit](https://github.com/jesseduffield/lazygit)
- Linux
  - [Amazon Linux => Production](https://aws.amazon.com/amazon-linux-2/?amazon-linux-whats-new.sort-by=item.additionalFields.postDateTime&amazon-linux-whats-new.sort-order=desc)
  - [Arch => Development](https://archlinux.org/)
  - [Kali => Sniffing and Vulnerability Analysis](https://www.kali.org/)
- [localtunnel](https://theboroer.github.io/localtunnel-www/)
- [Microsoft SQL Server](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)
- [Minikube](https://minikube.sigs.k8s.io/docs/)
- [Nginx](https://kubernetes.github.io/ingress-nginx/deploy/)
- [Posting](https://github.com/darrenburns/posting)
- [RabbitMQ](https://www.rabbitmq.com/)
- [Swagger](https://swagger.io/why-swagger/)
- Shell
  - Bash
  - Zsh
- [Telemetry](https://hub.docker.com/r/grafana/otel-lgtm)
    - [Grafana](https://opentelemetry.io/)
    - [OpenTelemetry](https://opentelemetry.io/)
    - [Prometheus](https://prometheus.io/)
- [Terraform](https://www.terraform.io/)

## References

- [S04E03---.NET-Microservices-Course-](https://github.com/binarythistle/S04E03---.NET-Microservices-Course-)
- [scholzj/aws-minikube](https://github.com/scholzj/aws-minikube)
- [cloud-formation-minikube](https://github.com/kobbikobb/cloud-formation-minikube)
- [Microsoft SQL Workshop](https://github.com/microsoft/sqlworkshops-sql2019workshop/blob/master/sql2019workshop/07_SQLOnKubernetes.md)

## Systems Design

### Microservices Architecture

Digram Illustrating Microservices Architecture and Communication

```mermaid
---
# title: Digram Illustrating Microservices Architecture and Communication
config:
    theme: neutral
---

graph LR;
    subgraph microServices[  ]
        direction LR;
        gateway( API Gateway )

        %% connections
        gateway <--> platformRestAPI
        gateway <--> commandsRestAPI
        platformService <--HTTP--> commandsRestAPI
        platformService --Publish--> messageBus
        messageBus --Subscribe--> commandsService

        subgraph platform[  ]
            subgraph platformService[ Platform Service ]
                platformRestAPI( REST API )
            end

            platformDb[( SQL Server )]
        end

        subgraph messageBus[ RabbitMQ Message Bus ]
        end

        subgraph commands[  ]
            subgraph commandsService[ Commands Service ]
                commandsRestAPI( REST API )
            end

            commandsDb[( RAM )]
        end
    end
```

### Cluster Architecture (Single Node)

Diagram Illustrating Cluster Architecture of Microservices Deployments and Service Configurations

<div align=center>

```mermaid
---
<!-- title: Diagram Illustrating Cluster Architecture of Microservices Deployments and Service Configurations -->
config:
    theme: neutral
---

graph TD;
    %% network interface
    networkInterface( Network Interface )
    networkInterface <--80--> ingressController
    networkInterface <--8080--> nodePort

    %% storage
    storage( Physical Storage )
    mssqlPersistentVolumeClaim <--> storage

    %% minikube cluster
    subgraph cluster[ Cluster ]
        direction BT;

        subgraph node[ Node ]
            %% commands service
            subgraph commandsPod[ Pod ]
                commandsServiceContainer( Commands Service Container)
            end

            commandsPod <--8080--> commandsClusterIP
            commandsPod <--666--> commandsClusterIP

            commandsClusterIP( Cluster IP \n Commands Service Cluster IP )

            %% platforms service
            subgraph platformsPod[ Pod ]
                platformsServiceContainer( Platforms Service Container)
            end

            platformsPod <--8080--> platformsClusterIP
            platformsPod <--666--> platformsClusterIP

            platformsClusterIP( Cluster IP \n Platforms Service Cluster IP )

            %% nginx
            subgraph nginxPod[ Pod ]
                nginxContainer( Nginx Container)
            end

            %% persistent volume Claim
            mssqlPersistentVolumeClaim(Persistent Volume Claim)
            mssqlPersistentVolumeClaim <--> mssqlContainer

            %% mssql server
            subgraph mssqlPod[ Pod ]
                mssqlContainer( Microsoft SQL Server Container)
            end

            mssqlPod <--1433--> mssqlClusterIP
            mssqlClusterIP <--> platformsClusterIP

            mssqlClusterIP( Cluster IP \n Microsoft SQL Server Service Cluster IP )

            %% node port
            nodePort( Node Port )


            %% ingress controller
            ingressController( Ingress Nginx Load Balancer )

            %% connections
            commandsServiceContainer <--8080--> nodePort
            nginxContainer <--80--> ingressController
            nginxContainer <--8080--> platformsServiceContainer
            nginxContainer <--8080--> commandsServiceContainer
            platformsClusterIP <--Asynchronous--> commandsClusterIP

        end
    end
```

</div>

### System Architecture (Single System)

Diagram Illustrating A Single System Kubernetes Services Architecture

<div align=center>

```mermaid
---
<!-- title: Diagram Illustrating A Single System Kubernetes Services Architecture -->
config:
    theme: neutral
---

graph TB;
    %% network hardware
    internet((( Internet )))
    gateway(( Gateway ))

    %% connections
    reverseProxy <--80--> networkInterface
    networkInterface <--> firewall
    firewall <--> gateway
    gateway <--> internet
    apiClient <--8080--> networkInterface <--8080--> nodePort
    ingressController <--80--> reverseProxy

    %% hardware
    subgraph hardware[ Hardware ]
        firewall( Firewall \n TCP 80 \n TCP 22)

        networkInterface( Network Interface )

        subgraph system[ Operating System ]
            %% apache httpd proxy
            reverseProxy( HTTPD Reverse Proxy )

            %% development environment
            subgraph devEnv[ Development Environment ]
                configurations( Configuration Files && Manifests)
                monitoring( Resource Monitoring )
                project( Root Project )
                apiClient( API Client )
            end

            %% docker
            subgraph runtime[ Docker ]
                %% minikube container
                subgraph minikube[ Minkube ]
                    %% minikube cluster
                    subgraph cluster[ Cluster ]
                        direction BT;
                            %% cluster diagram
                            diagram(Services \n View Cluster Diagram)

                            %% node port
                            nodePort( Node Port )

                            %% ingress controller
                            ingressController( Ingress Nginx Load Balancer )

                            %% cluster diagram
                            nodePort <--> diagram
                            ingressController <--> diagram
                    end
                end
            end
        end
    end
```

</div>

### AWS Cloud Architecture

Diagram Illustrating AWS Cloud Architecture of Single System Kubernetes Deployment

<div align=center>

```mermaid
---
<!-- title: Diagram Illustrating AWS Cloud Architecture of Single System Kubernetes Deployment -->
config:
    theme: neutral
---

graph TD;
    %% styles
    style user fill:#c46699,stroke:#333,stroke-width:4px
    style dev fill:#415999,stroke:#333,stroke-width:4px

    user( User )

    dev( Developer / Engineer )

    internet(((  Internet  )))

    domain80( Domain / Public IP Address:80 )

    domain22( Domain / IP Address:22 )

    %% internet connecting to vpc through gateway
    internet <--> internetGateway

    internetGateway --> routeTable

    %% user connecting to application running in ec2 instance
    user --> domain80

    domain80 --> internet

    %% developer connecting to ec2 instance through ssh
    dev --> domain22

    domain22 --> internet

    %% AWS cloud infrastructure
    subgraph vpc[ Virtual  Private Cloud]
        internetGateway(( Internet Gateway ))

        routeTable( Route Table \n 0.0.0.0/0 )

        allPorts --> internetGateway

        %% firewall redirecting traffic to their appropriate ports
        routeTable -- Domain / IP Address:22 --> port22
        routeTable -- Domain / IP Address:80 --> port80

        subgraph subnet[ Subnet ]
            subgraph firewall[ Security Group ]
                %% ingress ports
                port22( Port 22 TCP )
                port80( Port 80 TCP )

                %% egress ports
                allPorts( Port 0 -1 )

                port22 -- SSH Authentication --> ec2

                port80 --> ec2

                ec2 --> allPorts


                subgraph ec2[ EC2 Instance \n View Cluster Diagram ]
                end
           end
        end
    end
```

</div>
