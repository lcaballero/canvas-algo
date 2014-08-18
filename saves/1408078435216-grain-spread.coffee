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

  random = (args...) ->
    p = []
    for a in args
      if a.isVec
      then p.push(a.x, a.y)
      else p.push(a)
    p.push(true)
    _.random.apply(null, p)

  options =
    strip       : vec(60, 100)
    stretch     : vec( -10, 10)
    alphaRange  : vec(-.07, .07)
    alpha       : 0.3
    range       : vec(0, width)
    color       : color


  console.log(JSON.stringify(options, null, '  '))

  draw = (base) ->

    y = random(base.strip)

    f = (ay) ->
      ay + random(base.stretch)

    c = (ac) ->
      nc = ac + random(base.alphaRange)
      if nc > 1 then 1
      else if nc < 0 then 0
      else nc

    v = vec(0, f(y))
    a = base.color.alpha(base.alpha)

    for x in [base.range.x..base.range.y] by 1
      v = vec(x, f(v.y))
      g = c(a.alpha())
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

