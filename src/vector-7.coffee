newDrawing  = require '../lib/drawing'
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


  blue   = [0,0,150,1]
  red    = [150,0,0,1]
  green  = [0,150,0,1]

  scale   = 600/8
  rads1   = -(3/4)*PI*scale
  rads2   = PI/4*scale
  pixSize = 1 # 1/scale

  graphFn = (f, minX=rads1, maxX=rads2, inc=.01) ->
    @moveTo(minX, f(minX))
    for x in [minX..maxX] by inc
      @lineTo(x, f(x))
    @stroke()


  strokedFill = (tfn, afn, bfn, fadeFn, minX=rads1, maxX=rads2, inc=1) ->
    for x in [minX..maxX] by inc
      a = vec(x, tfn(x))
      b = vec(0, bfn(x) - afn(x))
      @strokeVec(a, b, fadeFn, pixSize, pixSize, pixSize)

  scaledSin = (x) -> scale*sin(x/scale)
  scaledCos = (x) -> scale*cos(x/scale)


  newDrawing({
    width   : width
    height  : height
    filename: filename
  })
  .clearCanvas()
  .toCartesian()
  .moveTo(0, 0)
  .fillStyle(blue.toColor())
  .strokeStyle(blue.toColor())
#  .axis({ x1:-40, x2:40, y1:-40, y2:40 })
  .translate(-rads1, 0)
  .draw(->
    {pctAlpha} = @

    @draw(strokedFill, scaledCos, scaledCos, scaledSin, pctAlpha(green))
    .draw(strokedFill, scaledCos, scaledSin, scaledCos, pctAlpha(red))
    .draw(strokedFill, scaledSin, scaledCos, scaledSin, pctAlpha(blue))


    .translate(rads1*2, 0)
    .scale(-1, 1)
    .draw(strokedFill, scaledCos, scaledCos, scaledSin, pctAlpha(green))
    .draw(strokedFill, scaledCos, scaledSin, scaledCos, pctAlpha(red))
    .draw(strokedFill, scaledSin, scaledCos, scaledSin, pctAlpha(blue))
  )
