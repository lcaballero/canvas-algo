newDrawing  = require '../lib/drawing'


module.exports = (opts) ->

  defaults =
    width       : 960
    height      : 640

  { width, height, filename } = opts = _.defaults({}, opts or {}, defaults)

  NULL = vec()

  theme = [
    [74, 101, 120]
    [248, 203, 91]
    [244, 157, 51]
    [219, 83, 50]
    [141, 64, 69]
  ]

  newDrawing({
    width   : width
    height  : height
    filename: filename
  })
  .clearCanvas(colors.white.toColor())
  .toCartesian()
  .moveTo(0, 0)
  .strokeStyle(colors.black.toColor())
  .draw(->

    # - Generate some numbers in a range.
    # - Total the number and divide the the total range by that.
    # - Each section can then be calculated.

    sections = (_.random(1, 10) for n in [0..21])
    total    = _.reduce(sections, (sum, num) -> sum + num)
    base     = _2PI / (total + sections.length)

    console.log(sections, total, base)

    a   = 0
    ra  = 150
    rb  = 300

    for s,i in sections
      b = s * base
      c = _.random(ra, rb)
      fill = [].concat(theme[ i % theme.length ]).alpha(.6)
      stroke = [].concat(theme[ i % theme.length ])

      @beginPath()
        .fillStyle(fill.toColor())
        .moveTo(NULL)
        .arc(0, 0, c, a, a+b)
        .lineTo(NULL)
        .fill()

      @beginPath()
        .strokeStyle(stroke.toColor())
        .lineWidth(2)
        .moveTo(NULL)
        .arc(0, 0, c, a, a+b)
        .lineTo(NULL)
        .stroke()

      a += b + (base)
  )