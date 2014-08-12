_ = require('lodash')

module.exports = (ctx) ->

    dump = (lead, arr) ->
        for a in arr
            console.log(lead, a)

    funcs = []
    other = []
    strings = []
    numbers = []
    booleans = []
    objects = []

    for k,v of ctx
        if _.isFunction(v)
            funcs.push(k)
        else if _.isString(v)
            strings.push(k)
        else if _.isNumber(v)
            numbers.push(k)
        else if _.isBoolean(v)
            booleans.push(k)
        else if _.isObject(v)
            objects.push(k)
        else
            other.push(k)

    dump('funcs', funcs)
    dump('strings', strings)
    dump('numbers', numbers)
    dump('boolean', booleans)
    dump('objects', objects)
    dump('other', other)
        
    console.log()
    console.log("Total Properties: #{i}")
    console.log(
        "Funcs: #{funcs.length}, Strings: #{strings.length},"+
        " Numbers: #{numbers.length}, Others: #{other.length},"+
        " Booleans: #{booleans.length}, Objects: #{objects.length}")
    lengths = funcs.length + strings.length + numbers.length +
        other.length + booleans.length + objects.length
    console.log("Combined: #{lengths}")

