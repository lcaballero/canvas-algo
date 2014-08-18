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

  addRandom = (a, bv, minVal, maxVal) ->
    rv = a + random(bv)
    if minVal?
      rv = max(minVal, rv)
    if maxVal
      rv = min(maxVal, rv)
    rv

  draw = (base) ->

    y = random(base.strip)

    c = (ac) ->
      nc = addRandom(ac, base.alphaRange)
      if nc > 1 then 1
      else if nc < 0 then 0
      else nc

    c = (ac) -> addRandom(ac, base.alphaRange, 0, 1)

    v = vec(0, addRandom(y, base.stretch))
    a = base.color.alpha(base.alpha)

    for x in [base.range.x..base.range.y] by 1
      v = vec(x, addRandom(v.y, base.stretch))
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

