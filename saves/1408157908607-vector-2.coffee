newDrawing  = require '../lib/drawing'
textures    = require '../lib/texture-plugins'
vec         = require '../lib/vec'


module.exports = (opts) ->

  defaults =
    width       : 600
    height      : 400

  { width, height, filename } = opts = _.defaults({}, opts or {}, defaults)

  view = {
    minX : -width/2
    maxX :  width/2
    minY : -height/2
    maxY :  height/2
  }

  pv = vec( 100, 100 )
  a1 = vec( 100, -30 )

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

  pctAlpha = (color) -> (pct) -> @fillStyle(color.alpha(pct).toColor())
  viewX = -> _.random(view.minX, view.maxX)
  viewY = -> _.random(view.minY, view.maxY)
  viewV = -> vec(viewX(), viewY())

  newDrawing({
      width   : width
      height  : height
      filename: filename
    })
    .clearCanvas()
    .toCartesian()
    .moveTo(0, 0)
    .strokeStyle([150, 0, 0].toColor())
    .fillStyle(colors[3].toColor())
    .strokeVec(vec(), pv, pctAlpha(colors[0]))
    .strokeVec(pv, a1, pctAlpha(colors[3]))
    .draw(->
      for i in [0..300]
        index = _.random(0, colors.length - 1)
        cc = colors[index]
        p = viewV()
        v = viewV()
        @fillStyle(cc.toColor())
          .strokeVec(p,v, pctAlpha(cc))
    )

