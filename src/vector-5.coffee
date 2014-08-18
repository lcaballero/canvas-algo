newDrawing  = require '../lib/drawing'
textures    = require '../lib/texture-plugins'
vec         = require '../lib/vec'


module.exports = (opts) ->

  defaults =
    width       : 600
    height      : 400

  { width, height, filename } = opts = _.defaults({}, opts or {}, defaults)

  colors = ((k=150, opacity=1) -> [
    [k +  0, 0, 0, opacity]
    [k + 10, 0, 0, opacity]
    [k + 20, 0, 0, opacity]

    [0, k +  0, 0, opacity]
    [0, k + 10, 0, opacity]
    [0, k + 20, 0, opacity]

    [0, 0, k +  0, opacity]
    [0, 0, k + 10, opacity]
    [0, 0, k + 20, opacity]
  ])()

  options = (p, v, df, alpha, color) ->
    p     ?= vec(0, 0)
    v     ?= vec(150, 150)
    df    ?= vec(.9, 1.1)
    color ?= _.sample(colors)

    {
      p     : p
      v     : v
      a     : v.rotate(alpha)
      df    : vec(.9, 1.1)
      color : color
    }

  newDrawing({
    width   : width
    height  : height
    filename: filename
  })
  .clearCanvas()
  .toCartesian()
  .moveTo(0, 0)
  .fadingWalkAndStroke(options(vec(   0,   0), vec( 150,  150), null, -HALF_PI, _.sample(colors)))
  .fadingWalkAndStroke(options(vec( -10,  30), vec(-150, -150), null, -HALF_PI, _.sample(colors)))
  .fadingWalkAndStroke(options(vec( -10, -30), vec(-150, -150), null,  HALF_PI, _.sample(colors)))

