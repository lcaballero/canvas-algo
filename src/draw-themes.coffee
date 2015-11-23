newDrawing  = require '../lib/drawing'
themeColors = require './themes'


module.exports = (opts) ->

  defaults =
    width       : 960
    height      : 640

  { width, height, filename } = opts = _.defaults({}, opts or {}, defaults)

  newDrawing({
    width   : width
    height  : height
    filename: filename
  })
  .clearCanvas(colors.white.toColor())
  .toCartesian()
  .moveTo(0, 0)
  .draw(->

    colors = _.flatten(_.map(_.values(themeColors), (theme) -> _.map(theme, (c) -> c.toColor())))
    colors = _.shuffle(colors)

    dim = vec(20,20)
    border = vec(2,2)
    v   = vec(0,0)

    @translate(-width/2, -height/2)

    x = 0
    y = 0
    i = 0
    while (y < height)
      index = i % colors.length
      c = colors[index]
      @fillStyle(c).fillRect(v.add(border), dim)

      x += dim.x + border.x

      if x >= width
        x = 0
        y += dim.y + border.y

      if i % colors.length is 0
        colors = _.shuffle(colors)

      v = vec(x, y)
      i++
  )
