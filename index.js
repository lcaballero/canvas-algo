#!/usr/bin/env node

require('coffee-script/register')
var drawings    = require('./src/')
var path        = require('path')

var argv = process.argv


var dir = path.resolve(__dirname, "images/")
drawings(dir)[argv[2]]()
