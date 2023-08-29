# Nim Microservice

A spike/POC around a microservice written in nim.

Mainly checking on package availability for the following:

- Webserver (API - prologue)
- JSON (serialization - jsony)
- ODBC/Database (database - ???)
- HTTP Client (remote calls - std/httpclient)
- Redis Client (caching)
- Schema Validation (bounds checking)

So that I can have an easy "go to" reference if I want to re-write
some of my sites (or create a new one) in nim instead of other
preferred languages, and so that I can benchmark resultant
binary/dependency size and performance (as well as just have fun
enhancing my nim skills!).

# Notes

Check some docker info (easier to profile usage):

```
make docker-build docker-run
docker images # NOTE - only 9MB used in disk space for the running image, including entire OS
docker stats # NOTE - never more than 1 MB of RAM usage, even with siege -r1000 -c9 http://127.0.0.1:8080
```
