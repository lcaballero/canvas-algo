require './globals'
require('./random-store')()
require '../lib/color-extensions'

path       = require 'path'
textures   = require('./textures')

module.exports = (dir, stamp) ->

  stamp = if stamp? then "#{stamp}-" else ""
  dir ?= path.resolve(__dirname, "../images")

  toImages = (f, arr...) ->
    rs = {}
    for d in arr
      ((dwg) ->
        image   = path.resolve(dir, "#{stamp}#{dwg}.png")
        rs[dwg] = -> f(dwg)({ filename: image }))(d)
    rs

  lookup            = (name) -> textures[name]
  req               = (name) -> require("./#{name}")

  drawings          = toImages(req,
    'vlade', 'graphing', 'sandgrains', 'grain-spread',
    'vector-1', 'vector-2', 'vector-3', 'vector-4',
    'vector-5', 'vector-6', 'vector-7', 'vector-8')

  drawings.textures = toImages(lookup,
    'soft-red', 'soft-yellow')

  return drawings
