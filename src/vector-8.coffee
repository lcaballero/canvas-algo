newDrawing  = require '../lib/drawing'
textures    = require '../lib/texture-plugins'
vec         = require '../lib/vec'


module.exports = (opts) ->

  defaults =
    width       : 960
    height      : 640

  { width, height, filename } = opts = _.defaults({}, opts or {}, defaults)

  view =
    x : vec(  -width/2,  width/2)
    y : vec( -height/2, height/2)

  black  = [0,0,0]
  white  = [255,255,255]
  axis   = {x1:-7, x2:7, y1:-7, y2:7}
  NULL   = vec(0,0)
  PI_4   = PI / 4
  SQRT_2 = sqrt(2)


  drawCenterCircles = (opts) ->
    { centers } = opts
    for r in centers
      @edgeArc(NULL, r).stroke()

  drawSideCircles = (opts) ->
    { offsetCenters, radi } = opts
    v = vec(offsetCenters, 0)
    @edgeArc(v.scale(-1,0), radi).stroke()
    @edgeArc(v, radi).stroke()

  drawConsecutiveCircles = (opts) ->
    { centers, radius, position } = opts
    positions = _.map(centers, (n) -> 2 * radius * n)
    for x in positions
      a = position.add(x)
      @edgeArc(a, radius).stroke()

  stackedSquares = (opts) ->
    { edge, dim, offset } = opts
    pos1 = vec( edge, 0).rotate(-PI_4)
    pos2 = vec(-edge, 0).rotate(-PI_4)

    squareInter = pythagorean(a: edge, b: edge)
    w     = dim.x - squareInter - (offset * 2)
    dim2  = vec(w, w)
    cx1   = pythagorean(a: offset, b: offset)
    pos3  = vec(0, edge + cx1).rotate(-PI_4)

    @save()
    .rotate(PI_4)
    .strokeRect(pos1, dim)
    .strokeRect(pos2, dim)
    .strokeRect(pos3, dim2)
    .rotate(PI)
    .strokeRect(pos1, dim)
    .strokeRect(pos2, dim)
    .restore()

  cone = (opts) ->

    { cornersOfRightSquares, offsetFromSquares, centerRadius, widthOfRods, coneLength } = opts

    leftEdgeOfRod   = pythagorean(a: offsetFromSquares , b: offsetFromSquares)
    rightEdgeOfRod  = pythagorean(a: widthOfRods       , b: widthOfRods)

    v  = vec(cornersOfRightSquares + rightEdgeOfRod + leftEdgeOfRod, 0)

    r2  = centerRadius + offsetFromSquares
    a   = (v.x - 90) / SQRT_2
    b   = pythagorean(a: a, c: r2)
    ca  = lawOfCosines(a: a, b: b, c: r2).C - PI_4

    p1 = vec(90,0).add(pol(r2, -ca))
    a1 = vec(r2+130,0).rotate(-PI_4)

    @beginPath()
    .moveTo(r2 + 90, 0)
    .arc(90, 0, r2, 0, -ca, true)
    .lineTo(p1.add(a1))
    .lineTo(r2 + 90, 0)
    .stroke()

  rods = (opts) ->
    { w, corner } = opts
    @save()
      .translate(corner, 0)
      .rotate(-PI_4)
      .strokeRect(NULL, w, 20)
      .strokeRect(vec(w + 20, 0), 70, 20)
      .strokeRect(vec(w + 110, 0), 30, 20)
      .restore()

    @save()
      .translate(-corner, 0)
      .rotate(PI-PI_4)
      .strokeRect(NULL, w, 20)
      .strokeRect(vec(w + 20, 0), 70, 20)
      .strokeRect(vec(w + 110, 0), 30, 20)
      .restore()


  newDrawing({
    width   : width
    height  : height
    filename: filename
  })
  .clearCanvas(white.toColor())
  .toCartesian()
  .moveTo(0, 0)
  .draw(->
    @strokeStyle(black.toColor())

    centerRadius = 150
    @draw(drawCenterCircles, centers : [100, 150])
    @draw(drawSideCircles, offsetCenters: 90, radi: centerRadius)

    r = 45
    v = vec(150 + r, 0)
    @draw(drawConsecutiveCircles, centers: [ 0, 1, 2],  radius: r, position: v)
    @draw(drawConsecutiveCircles, centers: [ 0,-1,-2],  radius: r, position: v.ccw180())


    edge    = 60
    dim     = vec(200, 200)
    offset  = 10
    corner  = 75
    @draw(stackedSquares, edge: edge, dim: dim, offset: offset)

    @draw(rods, w: dim.x, corner: corner)

    @draw(cone,
      centerRadius          : centerRadius
      cornersOfRightSquares : corner
      offsetFromSquares     : offset
      widthOfRods           : 20
      coneLength            : 110
    )
  )







