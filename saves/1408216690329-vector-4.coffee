newDrawing  = require '../lib/drawing'
textures    = require '../lib/texture-plugins'
vec         = require '../lib/vec'


module.exports = (opts) ->

  defaults =
    width       : 600
    height      : 400

  { width, height, filename } = opts = _.defaults({}, opts or {}, defaults)

  c = (r, g, b) -> [r,g,b]

  options = (k=150, v, p) ->
    v ?= vec(150, 150)
    p ?= vec(0,0)

    {
      p : p
      v : v
      a : v.cw90()
      d : vec(-10,10)
      colors : [
        c(k +  0, 0, 0)
        c(k + 10, 0, 0)
        c(k + 20, 0, 0)

        c(0, k +  0, 0)
        c(0, k + 10, 0)
        c(0, k + 20, 0)

        c(0, 0, k +  0)
        c(0, 0, k + 10)
        c(0, 0, k + 20)
      ]
    }

  draw = (opts) ->
    { p, v, a, d, colors } = opts
    { pctAlpha } = @
    { randomRange } = _.random

    r   = a.magnitude()
    dv  = v.scale(1/r)
    k   = r
    c1  = _.sample(colors)

    while (--k >= 0)
      @strokeVec(p, a, pctAlpha(c1))
      p = p.add(dv)
      a = a.add(0, randomRange(d))


  newDrawing({
    width   : width
    height  : height
    filename: filename
  })
  .clearCanvas()
  .toCartesian()
  .moveTo(0, 0)
  .draw(draw, options(150, vec( 150,  150), vec(  0,   0)))
  .draw(draw, options(150, vec(-150, -150), vec(-10,  30)))
  .draw(draw, options(150, vec( 150,  150), vec(-160, -180)))
