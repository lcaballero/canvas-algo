newDrawing = require './../lib/drawing'

width                 = 450
height                = 300
steps                 = 34
base_color            = [150,0,0,1]
base_green_component  = 140
horizontal_size       = vec(50, 0)
vertical_size         = vec(0, 15)


zipping = () ->
  as = _.range(   0, _2PI, _2PI / steps )
  bs = _.range( .25,    1,  .75 / steps )
  ({arc:e, opacity:bs[i], scale: bs[i], i:i } for e,i in as)


fn = (arc, color, h, v) ->
  @save()
      .rotate(arc)
      .translate(90, 0)
      .strokeStyle(color)
      .fillStyle(color)
      .beginPath()
        .moveTo(0   , v.y   )
        .lineTo(h.x , 0     )
        .lineTo(0   , -v.y  )
        .lineTo(-h.x, 0     )
        .lineTo(0   , v.y   )
      .fill()
    .restore()

f = ({arc, opacity, scale, i}) ->
  @draw(
    fn,
    arc,
    base_color
      .alpha( opacity )
      .green( base_green_component + (i*2) )
      .toColor(),
    horizontal_size.scale( scale, scale ),
    vertical_size.scale( scale, scale )
  )

selectMany = ->
  for e,i in zipping()
    @draw(f, e, i)


module.exports = (opts) ->

  opts = _.defaults({}, opts or {})

  newDrawing({
      width   : width
      height  : height
      filename: opts.filename
    })
    .fillStyle("#ffffff")
    .fillRect(0,0, width, height)
    .toCartesian()
    .draw(selectMany)


