

module.exports = {

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

  axis : ({x1, x2, y1, y2}) ->
    @save()
      .moveTo(x1, 0)
      .lineTo(x2, 0)
      .moveTo(0, y1)
      .lineTo(0, y2)
      .stroke()
      .restore()

}
