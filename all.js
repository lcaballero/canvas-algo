#!/usr/bin/env node

require('coffee-script/register')

var path     = require('path')
var drawings = require('./src/')



var dir = path.resolve(__dirname, "exhibit/")
var dwg = drawings(dir)

dwg.graphing()
dwg.vlade()
dwg.sandgrains()
dwg.textures['soft-red']()
dwg.textures['soft-yellow']()
dwg['grain-spread']()
dwg['vector-1']()
dwg['vector-2']()
