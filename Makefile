all: dev

# If using nim 2.0 and httpx instead of httpasyncserver (usestd) --mm:refc can fix vs orc/arc

release:
	nimble install --mm:orc -d:usestd

dev:
	nimble build --mm:orc -d:usestd

clean:
	-rm -f nim_microservice.bin
