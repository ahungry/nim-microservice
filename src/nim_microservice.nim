import prologue
import json
import jsony
import std/[logging, strformat]

type Summ = object
    x: int
    y: int

type Person = object
    name: string

func getData[T](ctx: Context, schema: typedesc[T]): T =
  ctx.request.body().fromJson(schema)

proc myDebugRequestMiddleware*(appName = "Prologue"): HandlerAsync =
  result = proc(ctx: Context) {.async.} =
    logging.info "debugRequestMiddleware->begin"
    logging.debug(&"Received JSON: {ctx.request.body()}")
    # do something before
    await switch(ctx)
    # do something after
    logging.info "debugRequestMiddleware->End"

proc hello*(ctx: Context) {.async.} =
  resp($ %* {"Hello": "World"}) # $ is shorthand to stringify, %* shorthand to jsonify

proc summ*(ctx: Context) {.async.} =
  let data = ctx.getData(Summ)
  resp {"summ": data.x + data.y}.toJson()

proc greet*(ctx: Context) {.async.} =
  let data = ctx.getData(Person)
  resp {"message": &"Greetings {data.name}"}.toJson()

let settings = newSettings(debug = true)
var app = newApp(settings = settings)
app.use(myDebugRequestMiddleware())
app.addRoute("/", hello)
app.addRoute("/add", summ, @[HttpPost])
app.post("/summ", summ)
app.post("/greet", greet)
app.run()
