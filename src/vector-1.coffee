newDrawing  = require '../lib/drawing'
textures    = require '../lib/texture-plugins'
vec         = require '../lib/vec'


module.exports = (opts) ->

  defaults =
    width       : 600
    height      : 400

  { width, height, filename } = opts = _.defaults({}, opts or {}, defaults)


  pv = vec(   0,   0 )
  a1 = vec(  10,  10 )
  a2 = vec(  10, -10 )
  a3 = vec( -10, -10 )
  a4 = vec( -10,  10 )


  newDrawing({
      width   : width
      height  : height
      filename: filename
    })
    .clearCanvas()
    .toCartesian()
    .moveTo(0, 0)
    .lineVecs(pv, a1, a2, a3, a4)
