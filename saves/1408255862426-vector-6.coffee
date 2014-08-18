newDrawing  = require '../lib/drawing'
textures    = require '../lib/texture-plugins'
vec         = require '../lib/vec'


module.exports = (opts) ->

  defaults =
    width       : 600
    height      : 400

  { width, height, filename } = opts = _.defaults({}, opts or {}, defaults)

  view = {
    x       : vec(  -width/2,  width/2)
    y       : vec( -height/2, height/2)
    radius  : vec(0, _2PI)
  }

  particle  = [0,0,150]
  center    = [150,0,0,.6]
  radius    = 5

  { randomRange, unit } = _.random
  { viewV }       = _.random.viewRandomRange(view)

  newDrawing({
    width   : width
    height  : height
    filename: filename
  })
  .clearCanvas()
  .toCartesian()
  .moveTo(0, 0)
  .draw(->
    for i in [0..20]
      v = viewV()

      @fillStyle(center.toColor())
        .beginPath()
        .arc(v, radius, view.radius)
        .fill()

      for n in [0..300]
        maxDist = 120
        m = randomRange(maxDist)
        u = unit().scale(m)
        b = v.add(u)
        portion = m / maxDist
        fade = 1 - portion
        dim  = 5 * portion

        @fillStyle(particle.alpha(fade).toColor())
          .beginPath()
          .arc(b, dim, view.radius)
          .fill()
  )
#  .arc(viewV(), radius, 0, _2PI, false)
#  .arc(viewV(), radius, 0, _2PI, false)
