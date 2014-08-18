

module.exports = {

  graph : (opts, f) ->
    {minX, maxX, increment} = opts
    @moveTo(minX, f(minX))
    for x in [minX..maxX] by increment
      @lineTo(x, f(x))
    @stroke()

  draw : (args...) ->
    fn = args.shift()
    fn.apply(this, args);
    this

  toCenter : ->
    @translate(@width / 2, @height / 2)

  toCartesian : ->
    @toCenter().scale(1, -1)

  clearCanvas : (color = "#ffffff") ->
    @fillStyle(color).fillRect(0, 0, @canvas.width, @canvas.height)

  ticksX : (a, b, size=0.2, step=1) ->
    @save()
      .translate(0, size / -2)
      .ticks(a, b, size, step)
      .restore()

  ticksY : (a, b, size=0.2, step=1) ->
    @save()
      .rotate(PI/2)
      .translate(0, size / -2)
      .ticks(a, b, size, step)
      .restore()

  ticks : (a, b, size=0.2, step=1) ->
    @save()
      .draw(->
        for i in [a..b] by step
          @moveTo(i, 0).lineTo(i, size))
      .restore()

  iterate : (a, b, step, fn) ->
    i = 0
    for e in [a..b] by step
      @draw(fn, e, i++)
    this

  axis : ({x1, x2, y1, y2}) ->
    @save()
      .moveTo(x1, 0)
      .lineTo(x2, 0)
      .moveTo(0, y1)
      .lineTo(0, y2)
      .stroke()
      .restore()

  lineVecs : (v, vecs...) ->
    if !vecs? or vecs.length is 0
      throw new Error("Cannot draw a line with out a position vector")
    else
      @save().beginPath().moveTo(v)
      for e in vecs
        v = v.add(e)
        @lineTo(v)
      @stroke().restore()

  strokeVec : (p, v, cb, inc=1, pw=1, ph=1) ->
    if !p? or !v?
      throw new Error("Method strokeVecs requires a position vector and a target vector.")
    else
      r   = v.magnitude()
      dv  = v.scale(1/r)
      k   = r
      while (k >= 0)
        cb.call(@, k/r)
        @fillRect(p, pw, ph)
        p = p.add(dv)
        k -= inc
    @

  pctAlpha : (color) ->
    (pct) -> @fillStyle(color.alpha(color.alpha() * pct).toColor())

}
