

<p align="center"> Infraestructure as a code for s3(fronend) & fargate (backend)
    <br> 
</p>


## 🧐 About <a name = "about"></a>

This project is a infraestructure as a code with cloudformation (AWS) for a web application based on Django and React (Backend and frontend respectively) using the following techonologies

## 🏁 Getting Started <a name = "getting_started"></a>

This project requires order when building the architecture as each template depends on the output of the others, so te correct order for this would be


## 📝 Table of Contents

- [NetworkStack](#NetworkStack)
- [SecurityStack](#SecurityStack)
- [RoleStack](#RoleStack)
- [BastionStack](#BastionStack)
- [RdsStack](#RdsStack)
- [FargateStack](#FargateStack)
- [S3Stack](#S3Stack)
- [S3CodePipelineStack](#S3CodePipelineStack) 
- [FargateCodePipelineStack](#FargateCodePipelineStack) //in progress
### NetworkStack

    This stack creates a VPC, 10 subnets, IGW, 2 NATGW,2 EIP, 3 route tables with its respective routes

### SecurityStack

    This stack creates the security groups for databases, bastion tier, webservers and lambda functions (if using the VPC option)


### RoleStack

    This stack creates roles needed in general for the services
    #Note 
        all roles from all others stacks need to be moved here o vice versa (decision still pending)


### BastionStack

    This stack creates a HA Bastion tier, keep in mid that without this tiers there is no other acces to the VPC resources

### RdsStack
    This stack creates a RDS multi AZ instance with PostgreSql 12 engine
    #Note 
    Read replicas still pending

### FargateStack
    This stack creates a Load Balanced Fargate cluster, which by default pulls my django project (backend)
### S3Stack
    This stack creates a S3 static webhosting bucket,for it to hold all the static files from the react application (frontend)
### S3CodePipelineStack
    This stack createsa pipeline  for the react application to be deployed in the s3 bucket
* pulls code from github
* builds node to create a bundle.zip
* extract that bundle to the bucket
### FargateCodePipelineStack
    This stack creates a pipeline that deploys the django services (one by now as others micro services still in creation)

* pulls code from github
* runs docker build
* pushes to docker hub 2 images (the appropiaate version & latest)
* deploys to fargate with a Blue/Green Deployment
