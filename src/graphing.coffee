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

  { width, height, increment } = opts = _.defaults({}, opts or {}, defaults)

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
#    .draw(->
#      @moveTo(view.minX, 0)
#      for i in [view.minX..view.maxX] by increment
#        @lineTo(i, sin(i))
#      @stroke()
#    )
#    .draw(->
#      @moveTo(view.minX, 0)
#      for i in [view.minX..view.maxX] by increment
#        @lineTo(i, cos(i))
#      @stroke()
#    )
#    .draw(->
#      sc = 4
#      g = (x) -> 1 / x
#      f = (x, s) -> g(x * s)
#      a = .2 / sc
#      v = -.25
#
#      @moveTo(a-v, f(a, sc))
#      for i in [0..view.maxX] by increment
#        x = i + v
#        @lineTo(x, f(i, sc))
#      @stroke()
#    )
#    .draw(->
#      f = (x) -> pow(E, x)
#
#      @moveTo(view.minX, f(view.minX))
#      for i in [view.minX..view.maxX] by increment
#        x = i + 0
#        @lineTo(x, f(i))
#
#      @stroke()
#    )
#  .draw(->
#      f = (x) -> pow(E, x)
#
#      @moveTo(view.minX, f(-view.minX))
#      for i in [view.minX..view.maxX] by increment
#        x = i + 0
#        @lineTo(x, f(-i))
#
#      @stroke()
#    )
