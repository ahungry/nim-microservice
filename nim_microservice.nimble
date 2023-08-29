# Package

version       = "0.0.1"
author        = "ahungry"
description   = "sample microservice with nim"
license       = "MIT"
srcDir        = "src"
bin           = @["nim_microservice.bin"]

# Dependencies

# requires "nim == 2.0.0"
requires "nim >= 1.6.14"
requires "prologue == 0.6.4" # Web server
requires "jsony == 1.1.5" # JSON
