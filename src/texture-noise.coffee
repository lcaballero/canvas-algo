newDrawing  = require '../lib/drawing'


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

    generateNoise = (pix, d=1) ->
      pix = []
      for x in [0..width]
        pix[x] = []
        for y in [0..height]
          pix[x][y] = _.random(0, 255) / d
      pix


    smoothNoise = (pixels, x0, y0, w, h) ->
      x = x0 / 8
      y = y0 / 8

      fractX = x - floor(x)
      fractY = y - floor(y)

      x1 = (floor(x) + w) % w
      y1 = (floor(y) + h) % h

      x2 = (x1 + w - 1) % w
      y2 = (y1 + h - 1) % h

      value = 0
      value += fractX       * fractY        * pixels[x1][y1]
      value += fractX       * (1 - fractY)  * pixels[x1][y2]
      value += (1 - fractX) * fractY        * pixels[x2][y1]
      value += (1 - fractX) * (1 - fractY)  * pixels[x2][y2]

      (256 * value) % 256


    zoomedNoise = (pixels, fn, vx=1, vy=1, w=width, h=height) ->

      fn ?= (pixs, x, y) -> pixs[x][y]

      for x0 in [0..width]
        for y0 in [0..height]
          x = floor(x0/vx)
          y = floor(y0/vy)

          n1 = fn(pixels, x, y, w, h)
          c = [n1, n1, n1]

          @fillStyle(c.toColor())
            .fillRect(x0, y0, 1, 1)

    @toBottomLeft()
      .draw(zoomedNoise, generateNoise(), smoothNoise, 1, 1, width, height)

  )