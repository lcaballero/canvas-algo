#!/usr/bin/env node

require('coffee-script/register')

var path     = require('path')
var drawings = require('./src/')



var dir = path.resolve(__dirname, "exhibit/")
var dwg = drawings(dir)

dwg.graphing()
dwg.vlade()

