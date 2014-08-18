


module.exports = {
  ###
    @p - A positioning vector where other stroke lines are drawn
    @v - The vector along which stroke lines are drawn
    @a - The vector that will be repeatedly stroked out to a varying length.
        Typically this vector is perpendicular to the travel vector.
    @df - A vector representing a range by which to vary the @a
    @color - The color to paint the stroke vector
  ###
  fadingWalkAndStroke : (opts) ->
    { p, v, a, df, color } = opts
    { pctAlpha } = @
    { randomRange } = _.random

    r   = a.magnitude()
    dv  = v.scale(1/r)
    k   = r

    while (--k >= 0)
      @strokeVec(p, a, pctAlpha(color))
      p = p.add(dv)
      a = a.scale(randomRange(df))
    @

}