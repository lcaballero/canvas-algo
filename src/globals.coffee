global._    = require 'lodash'
global.vec  = require './../lib/vec'

do ->
  {
    floor, E, PI, abs, cos, sin, min, max, pow,
    acos, asin, atan, atan2, log, ceil, sqrt
  } = Math

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
  global.acos     = acos
  global.asin     = asin
  global.atan     = atan
  global.atan2    = atan2

  global.floor    = floor
  global.min      = min
  global.max      = max
  global.pow      = pow
  global.log      = log
  global.ceil     = ceil
  global.sqrt     = sqrt

  global.pol = (r, t) ->
    vec(r * cos(t), r * sin(t))

  global.colors = {
    red   : [255,0,0]
    green : [0,255,0]
    blue  : [0,0,255]
    black : [0,0,0]
    white : [255,255,255]
  }

  console.json = (args...) ->
    console.log.apply(console, _.map(args, (a) -> JSON.stringify(a, null, '  ')))

