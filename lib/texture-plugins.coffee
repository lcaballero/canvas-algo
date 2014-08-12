

module.exports = {
  repeatRandomFill: (dotCount, alphas, color, w, h, dw=1, dh=1) ->
    for alpha in alphas
      @draw(@fillRandom, dotCount, color.alpha(alpha), w, h, dw, dh)

  fillRandom: (count, color, w, h, dw=1, dh=1) ->
    @fillStyle(color.toColor())
    for i in [0..count]
      x = _.random(w)
      y = _.random(h)
      @fillRect(x, y, dw, dh)
}

