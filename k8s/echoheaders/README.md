# Echoheaders

This is a debugging servie that is handy to use when for example you want to
make sure that your application service recieves the proper x-forward-for &
x-forward-proto headers.

## Deploy service:
```
$ kubectl create -f echoheaders.yaml
```

## Edit ingress
Then edit the ingress to allow traffic on echo.akvolumen.org to the echoheaders
service (commented out)

## Inspect headers
```
$ http GET 'https://echo.akvolumen.org/'
HTTP/1.1 200 OK
Alt-Svc: clear
Content-Type: text/plain
Date: Wed, 04 Jan 2017 09:51:07 GMT
Server: nginx/1.9.11
Transfer-Encoding: chunked
Via: 1.1 google

CLIENT VALUES:
client_address=10.24.1.1
command=GET
real path=/
query=nil
request_version=1.1
request_uri=http://echo.akvolumen.org:8080/

SERVER VALUES:
server_version=nginx: 1.9.11 - lua: 10001

HEADERS RECEIVED:
accept=*/*
accept-encoding=gzip, deflate
connection=Keep-Alive
host=echo.akvolumen.org
user-agent=HTTPie/0.9.8
via=1.1 google
x-cloud-trace-context=a124f29a8f059a791757c689ae6f567e/4568040516299598638
x-forwarded-for=31.209.39.157, 35.186.204.113
x-forwarded-proto=https
BODY:
-no body in request-
```
