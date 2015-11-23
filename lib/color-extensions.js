/*******************************************************************************
 ******************************************************************************/
String.prototype.toColorArray = function() {

    var x = /#([a-gA-G0-9]{2})([a-gA-G0-9]{2})([a-gA-G0-9]{2})([a-gA-G0-9]{2})?/;

    var a = x.exec( this.toString() ).slice(1);

    if (!a[3]) {
        a.pop()
    }

    for (var i = 0; i < a.length; i++) {
        a[i] = parseInt( a[i], 16 );
    }

    return a;
};

/*******************************************************************************
 * Escapes reserved regex characters
 ******************************************************************************/
Array.prototype.toColor = function() {

    var n = this.length <= 3 ? 3 : 4;

    var pieces = this.concat( [0,0,0,0] ).slice(0,n);

    if (!this.length) {
        return "rgb(" + pieces.join() + ")";
    } else if (this.length <= 3) {
        return "rgb(" + pieces.join() + ")";
    } else if (this.length >= 4) {
        return "rgba(" + pieces.join() + ")";
    }
    return void(0);
};

/*******************************************************************************
 * Sets / Gets the red component of the array.
 ******************************************************************************/
Array.prototype.red = function() {
    switch (arguments.length) {
        case 1:
          v = [].concat(this)
          v[0] = arguments[0];
          return v;
        case 0: return this[0];
    }
};
/*******************************************************************************
 * Sets / Gets the green component of the array.
 ******************************************************************************/
Array.prototype.green = function() {
    switch (arguments.length) {
        case 1:
          v = [].concat(this)
          v[1] = arguments[0];
          return v;
        case 0: return this[1];
    }
};
/*******************************************************************************
 * Sets / Gets the blue component of the array.
 ******************************************************************************/
Array.prototype.blue = function() {
    switch (arguments.length) {
        case 1:
          v = [].concat(this)
          v[2] = arguments[0];
          return v;
        case 0: return this[2];
    }
};
/*******************************************************************************
 * Sets / Gets the alpha component of the array.
 ******************************************************************************/
Array.prototype.alpha = function() {
    switch (arguments.length) {
        case 1:
          v = [].concat(this)
          v[3] = arguments[0];
          return v;
        case 0: return this.length == 3 ? 0 : this[3];
    }
};


Array.prototype.grayscale = function() {
  var all = this.red() + this.green() + this.blue()
  var c   = Math.floor(all / 3)
  return [c,c,c]
};
Array.prototype.removeAlpha = function() {
  return this.removeChannel('a')
};
Array.prototype.removeRed = function() {
  return this.removeChannel('r')
};
Array.prototype.removeGreen = function() {
  return this.removeChannel('g')
};
Array.prototype.removeBlue = function() {
  return this.removeChannel('b')
};
Array.prototype.removeChannel = function(channel) {
  var red   = this.red(),
      green = this.green(),
      blue  = this.blue(),
      alpha = this.alpha();

  switch (channel) {
    case 'r':
    case 'red': return [0,green,blue,alpha];

    case 'g':
    case 'green': return [red,0,blue,alpha];

    case 'b':
    case 'blue': return [red,green,0,alpha];

    case 'a':
    case 'alpha': return [red,green,blue,1];

    default:
      return [red,green,blue,alpha];
  }
};

/**
 * Converts an HSL color value to RGB. Conversion formula
 * adapted from http://en.wikipedia.org/wiki/HSL_color_space.
 * Assumes h, s, and l are contained in the set [0, 1] and
 * returns r, g, and b in the set [0, 255].
 *
 * @param   Number  h       The hue
 * @param   Number  s       The saturation
 * @param   Number  l       The lightness
 * @return  Array           The RGB representation
 */
Array.prototype.hslToRgb = function hslToRgb() {
  var h = this[0], s = this[1], l = this[2];
  var r, g, b;

  if (s == 0) {
    r = g = b = l; // achromatic
  } else {
    function hue2rgb(p, q, t) {
      if(t < 0) t += 1;
      if(t > 1) t -= 1;
      if(t < 1/6) return p + (q - p) * 6 * t;
      if(t < 1/2) return q;
      if(t < 2/3) return p + (q - p) * (2/3 - t) * 6;
      return p;
    }

    var q = l < 0.5 ? l * (1 + s) : l + s - l * s;
    var p = 2 * l - q;
    r = hue2rgb(p, q, h + 1/3);
    g = hue2rgb(p, q, h);
    b = hue2rgb(p, q, h - 1/3);
  }

  return [Math.round(r * 255), Math.round(g * 255), Math.round(b * 255)];
};

/**
 * Converts an RGB color value to HSL. Conversion formula
 * adapted from http://en.wikipedia.org/wiki/HSL_color_space.
 * Assumes r, g, and b are contained in the set [0, 255] and
 * returns h, s, and l in the set [0, 1].
 *
 * @param   Number  r       The red color value
 * @param   Number  g       The green color value
 * @param   Number  b       The blue color value
 * @return  Array           The HSL representation
 */
Array.prototype.rgbToHsl = function() {
  var r = this[0], g = this[1], b = this[2];

  r /= 255, g /= 255, b /= 255;
  var max = Math.max(r, g, b), min = Math.min(r, g, b);
  var h, s, l = (max + min) / 2;

  if(max == min){
    h = s = 0; // achromatic
  }else{
    var d = max - min;
    s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
    switch(max){
      case r: h = (g - b) / d + (g < b ? 6 : 0); break;
      case g: h = (b - r) / d + 2; break;
      case b: h = (r - g) / d + 4; break;
    }
    h /= 6;
  }

  return [h, s, l];
};

/**
 * Converts an RGB color value to HSV. Conversion formula
 * adapted from http://en.wikipedia.org/wiki/HSV_color_space.
 * Assumes r, g, and b are contained in the set [0, 255] and
 * returns h, s, and v in the set [0, 1].
 *
 * @param   Number  r       The red color value
 * @param   Number  g       The green color value
 * @param   Number  b       The blue color value
 * @return  Array           The HSV representation
 */
Array.prototype.rgbToHsv = function() {
  var r = this[0], g = this[1], b = this[2];

  r = r/255, g = g/255, b = b/255;
  var max = Math.max(r, g, b), min = Math.min(r, g, b);
  var h, s, v = max;

  var d = max - min;
  s = max == 0 ? 0 : d / max;

  if(max == min){
    h = 0; // achromatic
  }else{
    switch(max){
      case r: h = (g - b) / d + (g < b ? 6 : 0); break;
      case g: h = (b - r) / d + 2; break;
      case b: h = (r - g) / d + 4; break;
    }
    h /= 6;
  }

  return [h, s, v];
};

/**
 * Converts an HSV color value to RGB. Conversion formula
 * adapted from http://en.wikipedia.org/wiki/HSV_color_space.
 * Assumes h, s, and v are contained in the set [0, 1] and
 * returns r, g, and b in the set [0, 255].
 *
 * @param   Number  h       The hue
 * @param   Number  s       The saturation
 * @param   Number  v       The value
 * @return  Array           The RGB representation
 */
Array.prototype.hsvToRgb = function() {
  var h = this[0], s = this[1], v = this[2];
  var r, g, b;

  var i = Math.floor(h * 6);
  var f = h * 6 - i;
  var p = v * (1 - s);
  var q = v * (1 - f * s);
  var t = v * (1 - (1 - f) * s);

  switch(i % 6){
    case 0: r = v, g = t, b = p; break;
    case 1: r = q, g = v, b = p; break;
    case 2: r = p, g = v, b = t; break;
    case 3: r = p, g = q, b = v; break;
    case 4: r = t, g = p, b = v; break;
    case 5: r = v, g = p, b = q; break;
  }

  return [r * 255, g * 255, b * 255];
}

