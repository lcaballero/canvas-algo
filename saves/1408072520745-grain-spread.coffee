newDrawing  = require '../lib/drawing'
textures    = require '../lib/texture-plugins'
vec         = require '../lib/vec'


module.exports = (opts) ->

  defaults =
    width       : 600
    height      : 400

  { width, height, filename, color,
    alphaRange, dotWidth, dotHeight } = opts = _.defaults({}, opts or {}, defaults)

  color = [255, 0, 0, .5]

  newDrawing({
      width   : width
      height  : height
      filename: filename
    })
    .clearCanvas()
    .toCartesian()
    .moveTo(0, 0)
#    .fillStyle([254, 0, 0, .5].toColor())
#    .fillRect(0, 0, 50, 50)
#    .fillStyle([254, 0, 0, .2].toColor())
#    .fillRect(25, 25, 50, 50)
    .draw(->
      y   = _.random(60, 100, true)

      f = (ay) ->
        ay + _.random(-10, 10, true)

      c = (ac) ->
        nc = ac + _.random(-.1, .1, true)
        if nc > 1 then 1
        else if nc < 0 then 0
        else nc

      v = vec(0, f(y))
      a = color.alpha(.3)

      for x in [0..200] by 1

        v = vec(x, f(v.y))
        a = a.alpha(c(a.alpha()))

        @fillStyle(a.toColor())
          .moveTo(x, 0)
          .fillRect(x, 0, 1, v.y)

    )

