require './globals'
require '../lib/color-extensions'

path      = require 'path'
textures  = require('./textures')

module.exports = (dir) ->

  dir ?= path.resolve(__dirname, "../images")

  return {

    vlade : ->
      require('./vlade')({
        filename: path.resolve(dir, 'vlade.png')
      })

    textures:
      softRed : ->
          textures.softRed({
            filename: path.resolve('soft-red.png')
          })
      softYellow : ->
        textures.softYellow({
          filename: path.resolve(dir, 'soft-yellow.png')
        })

    graphing: ->
      require('./graphing')({
        filename: path.resolve(dir, 'graphing.png')
      })

  }

