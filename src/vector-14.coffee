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
    color = theme[0].alpha(.3).toColor()

    @fillStyle(color)
      .toBottomLeft()

    rpt = ->
      x = _.random(0, width)
      y = _.random(0, height)
      vec(x,y)

    for n in [0..4000]
      @fillRect(rpt(), 1, 1)

    for n in [0..4000]
      r = _.random(0,5)

      @beginPath()
        .arc(rpt(),r,0,PI*2)
        .fill()

  )