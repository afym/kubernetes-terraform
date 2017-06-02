#### Creating the images

*Note :* You must to have the aws cli installed and admin credentials

###### validating 
```
# validating the packer configuration in sydney as an example :
$ packer validate -var-file values/sydney.json -var 'cluster_type=master' cluster.json
$ packer validate -var-file values/sydney.json -var 'cluster_type=node' cluster.json
```

###### building 
```
# validating the packer configuration in sydney as an example :
$ packer build -var-file values/sydney.json -var 'cluster_type=master' cluster.json
$ packer build -var-file values/sydney.json -var 'cluster_type=node' cluster.json
```