
module.exports = ->

  calcOppositeAngle = ({a,b,c}) ->
    ###
      a^2 == b^2 + c^2 - 2ab * cos(A)
      b^2 == a^2 + c^2 - 2ab * cos(B)
      c^2 == a^2 + b^2 - 2ab * cos(C)

      (c^2 - a^2 - b^2) / -2ab = cos(C)
      acos( (c^2 - a^2 - b^2) / -2ab ) = C
    ###
    num = (c*c) - (a*a) - (b*b)
    den = -2 * a * b
    div = num / den
    acos( div )

  ###
    So the values provided to these functions map to a triangle
    where the angle 'a' is opposite the side 'A', and the same
    is true for sides 'b', 'c', and angles 'B', 'C'.

                             C
                            /\
                       a  /   \
                        /      \ b
                      /         \
                    B ----------- A
                          c
  ###
  maths =
    lawOfCosines : ({a,b,c,A,B,C}) ->
      {
        a: a
        b: b
        c: c
        A: calcOppositeAngle({a:a,b:b,c:c})
        B: calcOppositeAngle({a:b,b:c,c:a})
        C: calcOppositeAngle({a:c,b:a,c:b})
      }
    ###
      a^2 + b^2 = c^2
    ###
    pythagorean : ({a,b,c}) ->
      if a? and b?
        return sqrt( (a*a) + (b*b) )
      if a? and c?
        return sqrt( (c*c) - (a*a) )
      if b? and c?
        return sqrt( (c*c) - (b*b))


  for k,v of maths
    global[k] = v

