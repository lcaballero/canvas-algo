newDrawing = require '../lib/drawing'
vec        = require '../lib/vec'


module.exports = (opts) ->

  defaults =
    width       : 400
    height      : 400

  { width, height } = opts = _.defaults({}, opts or {}, defaults)


  s = .1
  line = vec(cos(PI/6), sin(PI/6)).scale(200, 200)
  cw   = line.scale(s).cw90()
  ccw  = line.scale(s).ccw90()
  pix  = vec(1,1)

  color = [150,0,0,1]

  g = (x) -> 1 / x
  f = (x, s) -> g(x * s)
  h = 4

  newDrawing(opts)
    .clearCanvas()
    .toCartesian()
    .translate(.5, .5)
      .strokeStyle("#000000")
      .moveTo(-100, 0).lineTo(100, 0).stroke()
      .moveTo(0, -100).lineTo(0, 100).stroke()
    .moveTo(0, 0)
    .iterate(0, 1, .01,
      (i, index) ->
        v = line.scale(i)
        @fillStyle(color.toColor()).fillRect(v, pix)
    )

