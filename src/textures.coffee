newDrawing = require '../lib/drawing'
textures   = require '../lib/texture-plugins'


texture = (opts) ->

  defaults =
    width       : 600
    height      : 400
    color       : [150,0,0,.15]
    alphaRange  : (i/100 for i in [5..1] by -1)
    dotWidth    : 2
    dotHeight   : 2

  { width, height, filename, color,
    alphaRange, dotWidth, dotHeight } = opts = _.defaults({}, opts or {}, defaults)

  dots = floor((width * height) * .15) # 35% of the pixels

  newDrawing({
      width   : width
      height  : height
      filename: filename
    })
    .extend(textures)
    .fillStyle("#ffffff")
    .fillRect(0,0, width, height)
    .repeatRandomFill(dots, alphaRange, color, width, height, dotWidth, dotHeight)


module.exports = {
  'soft-red' : texture
  'soft-yellow' : (opts) -> texture(_.defaults({}, opts, { color: [256, 256, 0] }))
}
