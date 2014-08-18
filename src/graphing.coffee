newDrawing = require '../lib/drawing'


module.exports = (opts) ->

  defaults =
    width       : 400
    height      : 400
    minX        : -4
    maxX        : 4
    minY        : -2
    maxY        : 2
    increment   : .001
    tics        : {
      minX  : -4
      maxX  : 4
      minY  : -4
      maxY  : 4
    }
    axis : {
      x1 : -4
      x2 : 4
      y1 : -4
      y2 : 4
    }

  { width, height } = opts = _.defaults({}, opts or {}, defaults)

  sx = width / (opts.maxX - opts.minX)
  sy = height / (opts.maxY - opts.minY)

  view = _.defaults({}, opts, {
    scaleX  : sx
    scaleY  : sy
    scale   : min(sx, sy)
  })

  newDrawing(opts)
    .clearCanvas()
    .toCartesian()
    .scale(view.scale, view.scale)
    .lineWidth(1/view.scale)
      .strokeStyle("#000000")
      .axis(view.axis)
      .ticksX(view.tics.minX, view.tics.maxX, 0.2)
      .ticksY(view.tics.minY, view.tics.maxY, 0.2)
    .graph(view, sin)
    .graph(view, cos)
    .graph(view, (x) -> pow(x, 2))
    .graph(view, (x) -> -pow(x, 2))
