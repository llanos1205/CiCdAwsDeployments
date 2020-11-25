

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
    This stack createsa pipeline  for the react application to be deployed in the s3 bucket, 
    note the s3 bucket is private as all content is retrieved by clodufront
    the bucket structure is like this:
        -bucket/
            -Green/
                ...
                ...
                index.html
                ...
            -Blue/
                ...
                ...
                index.html
                ...
            version.json
    as you may noticed there are 2 folders to apply blue/green deployment,
    each folder is a origin for a diferent CloudFront distribution, 
    and there is a "version.json" file which states what version has each origin, 
    so the codebuild project deploys in the folder with the older version.
        {
            "Blue":"v1.0.0",
            "Green":"v1.0.1"
        }

* pulls code from github
* builds node to create a bundle.zip
* extract that bundle to the bucket
### CloduFrontStack
    This stack creates 2 distributions of cloud front to apply Blue/Green deployment to s3 webhosting, each distribution points to a diferente origin
    
### FargateCodePipelineStack
    This stack creates a pipeline that deploys the django services (one by now as others micro services still in creation)

* pulls code from github
* runs docker build
* pushes to docker hub 2 images (the appropiaate version & latest)
* deploys to fargate with a Blue/Green Deployment
