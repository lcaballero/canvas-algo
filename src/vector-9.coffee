module.exports = (opts, {newDrawing}) ->

  defaults =
    width       : 800
    height      : 600

  { width, height, filename } = opts = _.defaults({}, opts or {}, defaults)
  { red, green, blue, black } = colors

  newDrawing({
    width   : width
    height  : height
    filename: filename
  })
  .draw(->
    r1  = 100
    r2  = 50
    c1  = vec(0,0)
    c2  = vec(120,0)
    loc = lawOfCosines(a: r1, b: c2.x, c: r2)

    h1 = pol(r1, loc.A)
    h2 = pol(r2, loc.B)

    @strokeStyle(black.toColor())
      .edgeArc(c1, r1).stroke()
      .edgeArc(c2, r2).stroke()
    .strokeStyle(black.toColor())
      .beginPath()
      .moveTo(c1)
      .lineTo(h1)
      .stroke()
    .strokeStyle(black.toColor())
      .beginPath()
      .moveTo(c2)
      .lineTo(c2.add(-h2.x, h2.y))
      .stroke()
  )
