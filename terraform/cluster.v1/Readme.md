##### Kubernetes cluster v1.5.4 over AWS

![Kubernetes cluster](images/kubernetes-cluster-aws.jpg?raw=true "kubernetes cluster")

![kubernetes cluster auto scaling](images/auto-scaling.jpeg?raw=true "kubernetes cluster auto scaling")

* Before launch the terraform command you must to build de images with packer.
* Create a tfvars file in the values/* dir acoording with the region in AWS
* Dont change the private ip addres for the master (is used to set up the cluster)

```
$ terraform get
$ terraform plan -var-file=values/sydney.tfvars
$ terraform apply -var-file=values/sydney.tfvars
$ terraform destroy -var-file=values/sydney.tfvars
```