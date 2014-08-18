#!/usr/bin/env coffee

ts = new Date()

console.log(ts)


yyyy   = ts.getFullYear()
mm     = ts.getMonth()
dd     = ts.getDate()
hh     = ts.getHours()
m      = ts.getMinutes()
ss     = ts.getSeconds()
millis = ts.getMilliseconds()
p      = if hh > 12 then 'pm' else 'am'
hh     = hh % 12



s = "#{yyyy}-#{mm}-#{dd}-#{hh}.#{m}.#{ss}.#{millis}#{p}"

console.log(s)
