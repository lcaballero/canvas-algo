require('./globals')
require('./random-store')()
require('./mathy')()
require('../lib/color-extensions')


drawing   = require('../lib/drawing')
path      = require 'path'
textures  = require('./textures')


module.exports = (dir, stamp) ->

  stamp = if stamp? then "#{stamp}-" else ""
  dir ?= path.resolve(__dirname, "../images")

  toImages = (f, arr...) ->
    rs = {}
    options = {
      drawing : drawing
      newDrawing : (opts) ->
        drawing(opts)
          .clearCanvas()
          .toCartesian()
          .moveTo(0, 0)
    }
    for d in arr
      ((dwg) ->
        image   = path.resolve(dir, "#{stamp}#{dwg}.png")
        rs[dwg] = -> f(dwg)({ filename: image }, options))(d)
    rs

  lookup            = (name) -> textures[name]
  req               = (name) -> require("./#{name}")

  drawings          = toImages(req,
    'vlade', 'graphing', 'sandgrains', 'grain-spread',
    'vector-1',   'vector-2',   'vector-3',   'vector-4',
    'vector-5',   'vector-6',   'vector-7',   'vector-8',
    'vector-9',   'vector-10',  'vector-11',  'vector-12',
    'vector-13',  'vector-14',
    'draw-themes', 'texture-noise', 'fire-effect',
    'color-diff-1'
  )

  drawings.textures = toImages(lookup,
    'soft-red', 'soft-yellow')

  return drawings
