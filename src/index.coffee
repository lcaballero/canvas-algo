require './globals'
require '../lib/color-extensions'

path      = require 'path'
textures  = require('./textures')

module.exports = (dir) ->

  dir ?= path.resolve(__dirname, "../images")

  toImages = (f, arr...) ->
    rs = {}
    for d in arr
      ((dwg) ->
        image   = path.resolve(dir, "#{dwg}.png")
        rs[dwg] = -> f(dwg)({ filename: image }))(d)
    rs

  lookup            = (name) -> textures[name]
  req               = (name) -> require("./#{name}")
  drawings          = toImages(req, 'vlade', 'graphing', 'sandgrains')
  drawings.textures = toImages(lookup, 'soft-red', 'soft-yellow')

  return drawings
