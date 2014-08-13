Canvas     = require 'Canvas'
fs         = require 'fs'
_          = require 'lodash'
path       = require 'path'
dump       = require './dump-context'
extensions = require './drawing-plugins'


defaults =
    name   : 'text.png'
    width  : 200
    height : 200

createContext = (canvas) ->
    canvas.getContext('2d')

bindFunction = (target, name) ->
    target[name] = (args...) ->
      p = []
      for a in args
        if a.isVec
          p.push(a.x, a.y)
        else
          p.push(a)

      target.context[name](p...)
      this

bindAssignment = (target, name, value) ->
    target[name] = (val) ->
        target.context[name] = val
        this

bindAsContext = (target) ->
  for k,v of target.context
    if _.isFunction(v)
      bindFunction(target, k)
    else if _.isString(v)
      bindAssignment(target, k, v)
      target[k](v)
    else if _.isBoolean(v)
      bindAssignment(target, k, v)
      target[k](v)
    else if _.isNumber(v)
      bindAssignment(target, k, v)
      target[k](v)
  target


drawing = (opts) ->
  opts = _.defaults({}, opts or {}, defaults)
  {width, height, filename, stream, writer, callback} = opts

  canvas     = new Canvas(width, height)
  context    = createContext(canvas)
  stream    ?= canvas.pngStream()
  writer    ?= fs.createWriteStream(filename)
  callback  ?= ->

  stream.on('data', (c) -> writer.write(c))
  stream.on('end', ->
    console.log('finished writing:', filename)
    callback())

  _.defaults({}, opts, bindAsContext({
    canvas      : canvas
    context     : context
    stream      : stream
    writer      : writer
    extend      : (obj) -> _.extend(@, obj or {})
  }))
  .extend(extensions)


module.exports = drawing

