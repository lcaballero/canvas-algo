newDrawing  = require '../lib/drawing'
textures    = require '../lib/texture-plugins'
vec         = require '../lib/vec'


module.exports = (opts) ->

  defaults =
    width       : 600
    height      : 400

  { width, height, filename } = opts = _.defaults({}, opts or {}, defaults)

  p = vec(0,0)
  v = vec(150, 150)
  a = v.cw90()

  k = 150
  c = (r, g, b) -> [r,g,b]

  colors = [
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

  newDrawing({
      width   : width
      height  : height
      filename: filename
    })
    .clearCanvas()
    .toCartesian()
    .moveTo(0, 0)
    .draw(->
      { pctAlpha } = @

      r   = a.magnitude()
      dv  = v.scale(1/r)
      k   = r
      c1  = colors[ _.random(0, colors.length - 1, false) ]

      while (--k >= 0)
        @strokeVec(p, a, pctAlpha(c1))
        p = p.add(dv)
    )
