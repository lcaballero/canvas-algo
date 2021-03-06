var Vector = function( x2, y2, x1, y1 ) {

    x2 = x2 || 0;
    y2 = y2 || 0;
    x1 = x1 || 0;
    y1 = y1 || 0;

    this.x = x2 - x1;
    this.y = y2 - y1;
};

Vector.prototype = {
    isVec:true
    ,sub:function( x, y ) {
        return x.isVec ?
            vec( this.x, this.y, x.x, x.y ) :
            vec( this.x, this.y, x, y );
    }
    ,add:function( x, y ) {
        return x.isVec ?
            vec( this.x, this.y, -x.x, -x.y ) :
            vec( this.x, this.y, -x, -y );
    }
    ,scaleX:function( xs ) { return this.scale( xs, 1 ); }
    ,scaleY:function( ys ) { return this.scale( 1, ys ); }
    ,scale:function( xs, ys ) {
        ys = (ys === null || ys === undefined) ? xs : ys
        return vec( (xs || 0) * this.x, (ys || 0) * this.y );
    }
    ,translateX:function( xt ) { return this.translate( xt, 0 ); }
    ,translateY:function( yt ) { return this.translate( 0, yt ); }
    ,translate:function( xt, yt ) { return vec( this.x, this.y, -xt, -yt ); }
    ,isUpward:function() { return this.y > 0; }
    ,isDownward:function() { return this.y < 0; }
    ,isLeftward:function() { return this.x < 0; }
    ,isRightward:function() { return this.x > 0; }
    ,isNull:function() { return this.x == 0 && this.y == 0; }
    ,isVertical:function() { return this.x == 0 && this.y != 0; }
    ,isHorizontal:function() { return this.y == 0 && this.x != 0; }

    ,cw90: function() { return vec(this.y, -this.x); }
    ,ccw90: function() { return vec(-this.y, this.x); }
    ,ccw180: function() { return vec(-this.x, -this.y); }
    ,cw180: function() { return vec(-this.x, -this.y); }
    ,magnitude: function() {
      var a = this.x * this.x;
      var b = this.y * this.y;
      return Math.sqrt(a+b);
    }
    ,rotate: function(a) {
      var x = (this.x * Math.cos(a)) - (this.y * Math.sin(a));
      var y = (this.y * Math.cos(a)) + (this.x * Math.sin(a));
      return vec(x,y)
    }
};

var vec = function( x2, y2, x1, y1 ) {
    return new Vector( x2, y2, x1, y1 );
};

module.exports = vec;
