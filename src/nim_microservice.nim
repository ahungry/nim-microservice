import prologue
import json
import jsony
import std/[logging, strformat]

type Summ = object
    x: int
    y: int

proc hello*(ctx: Context) {.async.} =
  resp($ %* {"Hello": "World"}) # $ is shorthand to stringify, %* shorthand to jsonify

proc summ*(ctx: Context) {.async.} =
  logging.debug("Hello")
  let body = ctx.request.body()
  logging.debug(&"Received JSON: {body}")
  let data = body.fromJson(Summ)
  resp {"summ": data.x + data.y}.toJson()

let settings = newSettings(debug = true)
var app = newApp(settings = settings)
app.addRoute("/", hello)
app.addRoute("/add", summ, @[HttpPost])
app.post("/summ", summ)
app.run()
