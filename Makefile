all: dev

# If using nim 2.0 and httpx instead of httpasyncserver (usestd) --mm:refc can fix vs orc/arc

release:
	nimble install --mm:orc -d:usestd

dev:
	nimble build --mm:orc -d:usestd

docs:
	nim doc ./src/nim_microservice.nim
	mv src/htmldocs ./

depend:
	nim genDepend ./src/nim_microservice.nim

script:
	nim c --compileOnly --genScript ./src/nim_microservice.nim

clean:
	-rm -f nim_microservice.bin
