# echo_listen

## Usage

```bash
./echo_listen
```
```
[veb] Running app on http://localhost:8080/
```

Now, you can curl it with POST/GET
```bash
curl -X POST -d 'coucou=abc' 'http://localhost:8080'
curl -d 'coucou=abc' 'http://localhost:8080'
curl 'http://localhost:8080'
```
```
-------- [::1]:47198 --------
--- url
/
--- header
Host: localhost:8080
User-Agent: curl/8.7.1
Accept: */*
Content-Length: 10
Content-Type: application/x-www-form-urlencoded
--- data
coucou=abc
--------
```

## Build

```bash
make
```
