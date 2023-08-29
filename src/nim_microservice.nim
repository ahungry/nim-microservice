import prologue
import json
import jsony
import std/[logging, strformat, times]

type Summ = object
    x: int
    y: int

type Person = object
    name: string

func getData[T](ctx: Context, schema: typedesc[T]): T =
  ctx.request.body().fromJson(schema)

proc ctrlc() {.noconv.} =
  echo "\nClosing down the web server - goodbye!"
  # do clean up stuff (this handler is needed for docker to close)
  quit()

setControlCHook(ctrlc)

proc myDebugRequestMiddleware*(appName = "Prologue"): HandlerAsync =
  result = proc(ctx: Context) {.async.} =
    logging.debug(&"Req: {ctx.request.body()}")
    let t_start = cpuTime()
    await switch(ctx)
    let t_end = cpuTime()
    logging.debug(&"Time: {t_end - t_start:f} seconds")
    logging.debug(&"Res: {ctx.response.body}") # This can be mutated if needed (set handled)

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
