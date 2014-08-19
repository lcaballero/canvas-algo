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
  }

  { randomRange, unit } = _.random
  { viewV }             = _.random.viewRandomRange(view)

  cluster = (v, ma, mb, r=5, br=1, ba=1, particle) ->
    m = randomRange(ma, mb)
    u = unit().scale(m)
    b = v.add(u)

    portion       = m / mb
    fadingRadius  = r * (1 - portion) * br
    fadingOpacity = (1 - portion) * ba

    @fillStyle(particle.alpha(fadingOpacity).toColor())
      .beginPath()
      .arc(b, fadingRadius, 0, _2PI)
      .fill()

  newDrawing({
    width   : width
    height  : height
    filename: filename
  })
  .clearCanvas([0,0,0,.2].toColor())
  .toCartesian()
  .moveTo(0, 0)
  .draw(->

  )
  .draw(->
    reps      = 500
    r         = 6
    particle  = [255, 255, 204, 1]

    for i in [0..40]
      v = viewV()

      for n in [0..reps]
        @draw(cluster, v,   0, 120, r+0, .7, .4, particle)

      for n in [0..reps]
        @draw(cluster, v, 120, 240, r+1, .8, .5, particle)

      for n in [0..reps]
        @draw(cluster, v, 240, 360, r+2, .9, .6, particle)
  )

