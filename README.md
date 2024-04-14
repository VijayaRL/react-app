### Use Terraform to deploy EKS cluster on AWS.

Terraform with deploy following resources:
-	Networking: VPC, Subnet, Route Table, Internet Gateway, NAT Gateway, etc.
-	EKS: to deploy react app using Helm. 
-	ECR: to publish docker image. 

`Go to terraform/resources/ folder and run`

`Terraform Plan`

```
terraform init -var-file="dev.tfvars"
terraform plan -var-file="dev.tfvars"
```

`Terraform Apply`

```
terraform init -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"
```

### Build and push React app docker image to ECR. 

Using below commands we will authenticate to ECR and build and push image to it.

```
cd ../../docker-image
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 819370969351.dkr.ecr.us-east-1.amazonaws.com 
docker build -t 819370969351.dkr.ecr.us-east-1.amazonaws.com/react-app:latest .
docker push 819370969351.dkr.ecr.us-east-1.amazonaws.com/react-app:latest
```

### For CICD we can use following services 

-	CI: GitHub Actions can be used to automate build and push of image and publish to ECR 
-	CD: Argo CD can be installed on EKS to automatically publish Helm chart changes 

`Install ArgoCD` 

```
aws eks update-kubeconfig --region us-east-1 --name vrledu-dev
kubectl create ns argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.5.8/manifests/install.yaml
```

`Update service type from ClusterIP to LoadBalancer`

```
kubectl get service argocd-server -n argocd -o json | jq '.spec.type = "LoadBalancer"' | kubectl apply -f -
```

`Admin is the username and get password as`

```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

`Access the ArgoCD server using Service External IP`

```
kubectl -n argocd get svc
http://afcd0087135d647b8936f8d71517a035-1524876912.us-east-1.elb.amazonaws.com/applications
```


### Use Argo CD to deploy application to EKS. 

Once docker image is build and pushed to ECR, we can use above deployed Argo CD for the react app deployment.

`Run Argocd application`

```
create ns react-app
kubectl apply -f react-app.yaml
```

### Access the web application.

To access the web application, we can use it using External IP of the service which is load balance DNS of the react app. 

```
kubectl -n react-app get scv
Access web application - http://<load-balancer-dns>:8080
```