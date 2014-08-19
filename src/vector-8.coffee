newDrawing  = require '../lib/drawing'
textures    = require '../lib/texture-plugins'
vec         = require '../lib/vec'


module.exports = (opts) ->

  defaults =
    width       : 800
    height      : 600

  { width, height, filename } = opts = _.defaults({}, opts or {}, defaults)

  view =
    x : vec(  -width/2,  width/2)
    y : vec( -height/2, height/2)

  black = [0,0,0]
  white = [255,255,255]

  newDrawing({
    width   : width
    height  : height
    filename: filename
  })
  .clearCanvas(white.toColor())
  .toCartesian()
  .moveTo(0, 0)
  .draw(->
    @strokeStyle(black.toColor())

    f = (v, r, a1=0, a2=_2PI) ->
      @beginPath()
      .moveTo(v.add(r, 0))
      .arc(v, r, a1, a2)

    for r in [2*50, 3*50]
      @draw(f, vec(0,0), r).stroke()

    r = 150
    v = vec(3*30, 0)

    @draw(f, v.scale(-1,0), r).stroke()
    @draw(f, v, r).stroke()

    r = 45
    v = vec(2 * 50, 0)

    for n in [1,2,3]
      x = 2 * r * n
      a = v.add(x - r)
      @draw(f, a, r).stroke()

    v = v.scale(-1,0)
    for n in [-1,-2,-3]
      x = 2 * r * n
      a = v.add(x + r)
      @draw(f, a, r).stroke()

  )
