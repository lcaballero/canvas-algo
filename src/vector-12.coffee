newDrawing  = require '../lib/drawing'
themeColors = require './themes'


module.exports = (opts) ->

  defaults =
    width       : 960
    height      : 640

  { width, height, filename } = opts = _.defaults({}, opts or {}, defaults)

  theme = themeColors['81 Theme']

  newDrawing({
    width   : width
    height  : height
    filename: filename
  })
  .clearCanvas(colors.white.toColor())
  .toCartesian()
  .moveTo(0, 0)
  .draw(->

    chooseColor = (index) ->
      theme[index % theme.length]

    fill = (opts) ->
      { start, dim, color } = opts
      @moveTo(start)
        .fillStyle(color.toColor())
        .fillRect(start, dim)

    sq = (opts) ->
      { start, dim, color, pt1, pt2, pt3, pt4, pt5, pt6, pt7, pt8 } = opts
      @moveTo(start)
        .fillStyle(color.toColor())
        .fillRect(start, dim)

      @fillStyle(colors.white.toColor())
        .beginPath()
        .moveTo(pt1)
        .quadraticCurveTo(pt2, pt3)
        .quadraticCurveTo(pt4, pt5)
        .quadraticCurveTo(pt6, pt7)
        .quadraticCurveTo(pt8, pt1)
        .fill()

    innerStar = (opts) ->
      { start, dim, color, pt1, pt2, pt3, pt4, pt5, pt6, pt7, pt8, h } = opts
      @beginPath()
        .fillStyle(color.toColor())
        .moveTo(pt1)
        .quadraticCurveTo(start.add(h), pt3)
        .quadraticCurveTo(start.add(h), pt5)
        .quadraticCurveTo(start.add(h), pt7)
        .quadraticCurveTo(start.add(h), pt1)
        .fill()

    packCoords = (opts) ->
      { start, dim, index } = opts
      opts.color = chooseColor(index)
      opts.h     = dim.scale(.5, .5)
      opts.up    = vec(0,  opts.h.y)
      opts.down  = vec(0, -opts.h.y)
      opts.right = vec( opts.h.x, 0)
      opts.left  = vec(-opts.h.x, 0)

      opts.pt1   = start.add(opts.up)
      opts.pt2   = opts.pt1.add(opts.up)
      opts.pt3   = opts.pt2.add(opts.right)
      opts.pt4   = opts.pt3.add(opts.right)
      opts.pt5   = opts.pt4.add(opts.down)
      opts.pt6   = opts.pt5.add(opts.down)
      opts.pt7   = opts.pt6.add(opts.left)
      opts.pt8   = opts.pt7.add(opts.left)
      opts

    drawComp = (opts) ->
      @draw(fill, packCoords(opts))
      @draw(sq, packCoords(opts))

    i       = 0
    border  = vec(4,4)
    dim     = vec(80, 80)
    v       = vec(0,0).add(border)
    k       = 0

    @translate(-width/2, (-height/2))
    first = drawComp
    second = innerStar

    while (v.y < height)

      if k % 2 is 0
        first   = drawComp
        second  = innerStar
      else
        second  = drawComp
        first   = innerStar

      @draw(first, packCoords(start: v, dim: dim, index: i++))
      v = vec(v.x + dim.x + border.x, v.y)

      @draw(second, packCoords(start: v, dim: dim, index: i++))
      v = vec(v.x + dim.x + border.x, v.y)

      if v.x > width
        v = vec(0, v.y + dim.y + border.y)
        k += 1
  )