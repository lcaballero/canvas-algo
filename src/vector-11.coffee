newDrawing  = require '../lib/drawing'


module.exports = (opts) ->

  defaults =
    width       : 960
    height      : 640

  { width, height, filename } = opts = _.defaults({}, opts or {}, defaults)

  PI3   = PI/3
  NULL  = vec(0,0)
  theme = [
    [32, 63, 89]
    [54, 166, 191]
    [46, 154, 166]
    [91, 217, 217]
    [206, 242, 239]
  ]

  sketchOutline = (opts) ->
    { radius, thickness } = opts
    @beginPath()
    .strokeStyle(colors.green.toColor())

    for n in [1..6]
      @moveTo(NULL).lineTo(pol(radius, n*PI3))

    @arc(NULL, radius, 0, _2PI)
      .arc(NULL, radius - thickness, 0, _2PI)
      .stroke()

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
    r1  = 200
    thickness = 20
    sectorGap = PI * (thickness / 2 / (PI * r1))

    zig = ->
      v1        = vec(r1, 0)
      gap       = 5
      startA    = 0
      sectors   = [1,2,3,4,5,6]

      @beginPath()
        .moveTo(v1)

      startA  = 0
      for n,i in sectors
        endA    = (n * PI3) + sectorGap
        r       = r1 - (i * (thickness + gap))
        @arc(NULL, r, startA, endA)
        v = pol(r, endA)
        @lineTo(v)
        startA = endA

      startA  = (6 * PI3)
      for n in [6..1]
        endA    = ((n-1) * PI3) - sectorGap
        r       = r1 - (n * (thickness + gap)) + gap
        @arc(NULL, r, startA, endA, true)
        v = pol(r, endA)
        @lineTo(v)
        startA = endA

      @lineTo(v1)
      @fill()

    for n in [0..4]
      color = theme[n % theme.length]
      rot   = (-PI3 - (3 * sectorGap))

      @fillStyle(color.toColor())
        .draw(zig)
        .rotate(rot)
  )

###
  $("div.content").on("click", function(ev) {

    var s = []
    var e = $(this)

    if (e.is(".content")) {
      e.find(".frame > div")
        .each(function(i,e) {
          var rgb = $(e).css("background-color")
            .match(/([0-9]+)/g, ',')
          s.push('[', rgb.join(','), ']', '\n')
        })

      var theme = e.find("ul.assets-item-meta .name > a").text()
      console.log('theme', theme)
      console.log(s.join(""))

    }

  })

  var s = []
  var theme = 'Tiger Lilly'

  $("a:contains('" + theme + "')")
      .parents(".content")
      .find(".frame > div")
      .each(function(i,e) {
        var rgb = $(e).css("background-color")
          .match(/([0-9]+)/g, ',')
        s.push('[', rgb.join(','), ']', '\n')
      })
  console.log(theme)
  console.log(s.join(""))
###