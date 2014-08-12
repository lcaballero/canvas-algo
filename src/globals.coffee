global._    = require 'lodash'
global.vec  = require './../lib/vec'

do ->
  {floor, E, PI, abs, cos, sin, min, max} = Math
  global._2PI     = PI * 2
  global.E        = E
  global.abs      = abs
  global.cos      = cos
  global.sin      = sin
  global.floor    = floor
  global.PI       = PI
  global.min      = min
  global.max      = max

  console.json = (args...) ->
    console.log.apply(console, _.map(args, (a) -> JSON.stringify(a, null, '  ')))

