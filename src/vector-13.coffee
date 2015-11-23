newDrawing  = require '../lib/drawing'
themeColors = require './themes'


module.exports = (opts) ->

  defaults =
    width       : 960
    height      : 640

  { width, height, filename } = opts = _.defaults({}, opts or {}, defaults)

  theme = themeColors['81 Theme']

  pickColor = (index) ->
    theme[index % theme.length]

  newDrawing({
    width   : width
    height  : height
    filename: filename
  })
  .clearCanvas(colors.white.toColor())
  .toCartesian()
  .moveTo(0, 0)
  .draw(->

    packOpts = (opts) ->
      { pos, dim, index, near } = opts
      d  = dim.scale(.5,.5)

      up    = vec(    0,   d.y)
      right = vec(  d.x,     0)
      left  = vec( -d.x,     0)
      down  = vec(    0,  -d.y)

      ct    = pos.add(d)

      p1 = pos.add(up)
      p2 = p1.add(up)
      p3 = p2.add(right)
      p4 = p3.add(right)
      p5 = p4.add(down)
      p6 = p5.add(down)
      p7 = p6.add(left)
      p8 = p7.add(left)

      rv = {
        dim:dim, index:index, ct:ct, near:near,
        up:up, right:right, left:left, down:down,
        p1:p1, p2:p2, p3:p3, p4:p4, p5:p5, p6:p6, p7:p7, p8:p8
      }

      for n in [0..theme.length]
        rv["c" + n] = pickColor(index + n).toColor()

      rv

    star = (opts) ->
      { c1, c2, c3, c4, c5,
        p1, p2, p3, p4, p5, p6, p7, p8,
        near, ct } = opts

      f  = near
      ut = vec( 0,  f)
      dt = vec( 0, -f)
      lt = vec(-f,  0)
      rt = vec( f,  0)

      @beginPath()
        .fillStyle(c1)
        .moveTo(p1.add(rt))
        .quadraticCurveTo(ct, p3.sub(dt))
        .quadraticCurveTo(ct, p5.sub(lt))
        .quadraticCurveTo(ct, p7.sub(ut))
        .quadraticCurveTo(ct, p1.sub(rt))
        .fill()

      @beginPath()
        .fillStyle(c2)
        .moveTo(p1.add(ut))
        .quadraticCurveTo(p2, p3.add(lt))
        .lineTo(p2)
        .fill()

      @beginPath()
        .fillStyle(c3)
        .moveTo(p3.add(rt))
        .quadraticCurveTo(p4, p5.add(ut))
        .lineTo(p4)
        .fill()

      @beginPath()
        .fillStyle(c4)
        .moveTo(p5.add(dt))
        .quadraticCurveTo(p6, p7.add(rt))
        .lineTo(p6)
        .fill()

      @beginPath()
        .fillStyle(c5)
        .moveTo(p7.add(lt))
        .quadraticCurveTo(p8, p1.add(dt))
        .lineTo(p8)
        .fill()

    dim   = vec(97, 97)
    index = 0
    near  = 5
    pos   = vec(0,0)
    border = vec(4,4)

    @toBottomLeft()

    while (pos.y < height)
      opts  = packOpts(pos:pos, dim:dim, index:index, near:near)
      @draw(star, opts)

      pos = vec(pos.x + dim.x + border.x, pos.y)

      if pos.x > width
        pos = vec(0, pos.y + dim.y + border.y)

      index += _.random(0, theme.length)


  )