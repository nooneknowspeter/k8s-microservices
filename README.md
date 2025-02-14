# Project Overview

Built and deployed two .NET Microservices using the REST API pattern.

## Details

- Dedicated persistence layers for both services
- Deployed services to a Kubernetes cluster
- Employed the API Gateway pattern for routing
- Implemented synchronous messaging between services using HTTP and gRPC
- Built asynchronous messaging between services using an Event Bus (RabbitMQ)
- IaC and scripting for automated deployment and portability

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
- [Linux](https://archlinux.org/) => Arch (development) & Ubuntu (production)
- [localtunnel](https://theboroer.github.io/localtunnel-www/)
- [Microsoft SQL Server](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)
- [Minikube](https://minikube.sigs.k8s.io/docs/)
- [Nginx](https://kubernetes.github.io/ingress-nginx/deploy/)
- [Posting](https://github.com/darrenburns/posting)
- [RabbitMQ](https://www.rabbitmq.com/)
- [Swagger](https://swagger.io/why-swagger/)
- [Terraform](https://www.terraform.io/)

## References

- [S04E03---.NET-Microservices-Course-](https://github.com/binarythistle/S04E03---.NET-Microservices-Course-)
- [scholzj/aws-minikube](https://github.com/scholzj/aws-minikube)
- [cloud-formation-minikube](https://github.com/kobbikobb/cloud-formation-minikube)

## Solutions Architecture & Systems Design

### Solutions Architecture (Single System)

<div align=center>

```mermaid
---
# title: Overview of Solutions Architecture (Single System)
config:
    theme: neutral
---

graph TD;
internet((( Internet )))

internet <--> hardware

subgraph hardware[ Hardware ]
    subgraph system[ Operating System ]
        configurations( Configuration Files && Manifests)
        monitoring( Resource Monitoring )
        project( Root Project )
        subgraph runtime[ Docker ]
            subgraph minikube[ Minkube ]
                subgraph cluster[ Cluster ]
                    direction BT;

                    subgraph node[ Node ]
                        %% commands service
                        subgraph commandsPod[ Pod ]
                            commandsServiceContainer( Commands Service Container)
                        end

                        commandsPod <--8080--> commandsClusterIPService
                        commandsPod <--666--> commandsClusterIPService

                        subgraph commandsClusterIPService[ Cluster IP ]
                            commandsClusterIP( Commands Service Cluster IP )
                        end

                        %% platforms service
                        subgraph platformsPod[ Pod ]
                            platformsServiceContainer( Platforms Service Container)
                        end

                        platformsPod <--8080--> platformsClusterIPService
                        platformsPod <--666--> platformsClusterIPService

                        subgraph platformsClusterIPService[ Cluster IP ]
                            platformsClusterIP( Platforms Service Cluster IP )
                        end

                        %% nginx
                        subgraph nginxPod[ Pod ]
                            nginxContainer( Nginx Container)
                        end


                        %% node port
                        nodePort( Node Port )


                        %% ingress controller
                        ingressController( Ingress Nginx Load Balancer )

                        %% connections
                        commandsServiceContainer <--8080--> nodePort

                        nginxContainer <--80--> ingressController

                        nginxContainer <--8080--> platformsServiceContainer

                        nginxContainer <--8080--> commandsServiceContainer

                        platformsClusterIPService <--Asynchronous--> commandsClusterIPService

                    end
                end
            end
        end
    end
end
```

</div>

### AWS Cloud Architecture

<div align=center>

```mermaid
---
# title: Overview of Cloud Infrastructure
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

                port80 --> application

                ec2 --> allPorts


                subgraph ec2[ EC2 Instance ]
                    application( Application )
                end
           end
        end
    end
```

</div>
