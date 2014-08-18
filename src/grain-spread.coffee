newDrawing  = require '../lib/drawing'
textures    = require '../lib/texture-plugins'
vec         = require '../lib/vec'


module.exports = (opts) ->

  defaults =
    width       : 600
    height      : 400

  { width, height, filename } = opts = _.defaults({}, opts or {}, defaults)

  options =
    strip       : vec(60, 100)
    stretch     : vec( -7, 7)
    alphaRange  : vec(-.04, .04)
    alpha       : 0.3
    range       : vec(0, width)
    color       : [255, 0, 0]

  { addRandom, randomRange } = _.random

  draw = (base) ->

    y = randomRange(base.strip)
    v = vec(0, addRandom(y, base.stretch, 0))
    a = base.color.alpha(base.alpha)

    for x in [base.range.x..base.range.y] by 1
      v = vec(x, addRandom(v.y, base.stretch, 0))
      g = addRandom(a.alpha(), base.alphaRange, 0, 1)
      a = a.alpha(g)

      @fillStyle(a.toColor())
        .moveTo(x, 0)
        .fillRect(x, 0, 1, v.y)


  newDrawing({
      width   : width
      height  : height
      filename: filename
    })
    .clearCanvas()
    .toCartesian()
    .moveTo(0, 0)
    .translate(-width/2, 0)
    .draw(draw, options)

