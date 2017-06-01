#### Inside the master

```
$ kubectl run test --image=gcr.io/google_containers/echoserver:1.4 --port=8080
$ kubectl expose deployment test --type=NodePort
$ kubectl get service

NAME         CLUSTER-IP       EXTERNAL-IP    PORT(S)          AGE
kubernetes   10.254.0.1       <none>         443/TCP          31m
test         10.254.191.123   <nodes>        8080:30764/TCP   16s
```

Then in a browser put *http://node-ip:30764* and you will see something like :

```
CLIENT VALUES:
client_address=172.17.0.1
command=GET
real path=/
query=nil
request_version=1.1
request_uri=http://12.21.101.42:8080/

SERVER VALUES:
server_version=nginx: 1.10.0 - lua: 10001

HEADERS RECEIVED:
accept=text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
accept-encoding=gzip, deflate, sdch
accept-language=en-US,en;q=0.8
cache-control=max-age=0
connection=keep-alive
host=12.21.101.42:30764
upgrade-insecure-requests=1
user-agent=Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36
BODY:
-no body in request-
```