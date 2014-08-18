global._    = require 'lodash'
global.vec  = require './../lib/vec'

do ->
  {floor, E, PI, abs, cos, sin, min, max, pow} = Math
  global._2PI     = PI * 2
  global.HALF_PI  = PI / 2

  global.ccw90    = PI / 2
  global.ccw45    = PI / 4
  global.ccw30    = -PI / 6

  global.cw90     = -PI / 2
  global.cw45     = -PI / 4
  global.cw30     = -PI / 6

  global.E        = E
  global.PI       = PI

  global.abs      = abs
  global.cos      = cos
  global.sin      = sin
  global.floor    = floor
  global.min      = min
  global.max      = max
  global.pow      = pow

  console.json = (args...) ->
    console.log.apply(console, _.map(args, (a) -> JSON.stringify(a, null, '  ')))

