newDrawing  = require '../lib/drawing'
themeColors = require './themes'


module.exports = (opts) ->

  defaults =
    width       : 640
    height      : 128

  { width, height, filename } = opts = _.defaults({}, opts or {}, defaults)

  createBuffer = (w,h) ->
    buf = []
    for x in [0..w]
      r = []
      buf.push(r)
      for y in [0..h]
        r.push(0)
    buf


  newDrawing({
    width   : width
    height  : height
    filename: filename
  })
  .clearCanvas(colors.white.toColor())
  .toCartesian()
  .moveTo(0, 0)
  .draw(->

    fire    = createBuffer(width,height)
    palette = []
    w       = width
    h       = height

    for x in [0..height]
      color = [x / 3, 255, min(255, x * 2)]
      palette.push(color.hslToRgb().toColor())

    @toBottomLeft()

    k = 2
    while (k--)
      for x in [0..w]
        fire[x][h - 1] = abs(_.random(0, 32768)) % 256

      for x in [0..w]
        for y in [0..(h-1)]

          p1 = fire[(x - 1 + w) % w][(y + 1) % h]
          p2 = fire[x % w][(y + 1) % h]
          p3 = fire[(x + 1) % w][(y + 1) % h]
          p4 = fire[x % w][(y + 2) % h]

          fire[x][y] = ((p1 + p2 + p3 + p4) + 32) / 129;


      for x in [0..w]
        for y in [0..h]
          @fillStyle(palette[fire[x][y]])
            .fillRect(x,y,1,1)

  )