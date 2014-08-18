

module.exports = ->

  _ = require('lodash')

  addRandom = (a, bv, minVal, maxVal) ->
    rv = a + randomRange(bv)
    if minVal?
      rv = max(minVal, rv)
    if maxVal
      rv = min(maxVal, rv)
    rv

  randomRange = (args...) ->
    p = []
    for a in args
      if a.isVec
      then p.push(a.x, a.y)
      else p.push(a)
    p.push(true)
    _.random.apply(null, p)

  circ = vec(0, _2PI)

  viewX     = (v) -> randomRange(v)
  viewY     = (v) -> randomRange(v)
  viewV     = (x,y) -> vec(viewX(x), viewY(y))
  direction = -> randomRange(circ)
  unit      = ->
    theta = direction()
    vec(cos(theta), sin(theta))

  viewRandomRange = (view) ->
    viewX : -> viewX(view.x)
    viewY : -> viewY(view.y)
    viewV : -> viewV(view.x, view.y)

  _.defaults(_.random, {
    addRandom       : addRandom
    unit            : unit
    randomRange     : randomRange
    viewX           : viewX
    viewY           : viewY
    viewV           : viewV
    viewRandomRange : viewRandomRange
  })


