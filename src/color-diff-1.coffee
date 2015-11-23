newDrawing  = require '../lib/drawing'
themes      = require './themes'


module.exports = (opts) ->

  defaults =
    width       : 960
    height      : 640

  { width, height, filename } = opts = _.defaults({}, opts or {}, defaults)

  console.log('themes', themes)

  theme = themes["Professional"]

  newDrawing({
    width   : width
    height  : height
    filename: filename
  })
  .clearCanvas(colors.white.toColor())
  .toCartesian()
  .moveTo(0, 0)
  .beginPath()
    .lineTo(100, 100)
    .stroke()
  .draw(->
    dim = vec(20, 20)
    rd = 5
    gd = 3
    bd = 1
    index = 0

    resetColor = -> theme[index++ % theme.length]
    diffColor = (r,g,b) ->
      r : max(0, r - rd)
      g : max(0, g - gd)
      b : max(0, b - bd)

    c = resetColor()
    r = c.red()
    g = c.green()
    b = c.blue()

    pos = vec(0,0)

    @toBottomLeft()



    while (pos.y < height)

      if r - rd < 0 and g - gd < 0 and b - bd < 0
        c = resetColor()
        r = c.red()
        g = c.green()
        b = c.blue()

      { r, g, b } = diffColor(r, g, b)

      c = [r,g,b]

      console.log(c)

      @fillStyle(c.toColor()).fillRect(pos, dim)

      pos = vec(pos.x + dim.x, pos.y)

      if pos.x > width
        pos = vec(0, pos.y + dim.y)



  )

