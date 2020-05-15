# Example RancherOS on Digital Ocean managed by Terraform

    2019 Ondrej Sika <ondrej@ondrejsika.com>
    https://github.com/ondrejsika/terraform-do-rancheros-example


## Run Server

```
terraform init
terraform plan
terraform apply -auto-approve
```

## Connect

 ```
ssh rancher@ros.sikademo.com
```


## Destroy Infrastructure

```
terraform destroy -auto-approve
```
