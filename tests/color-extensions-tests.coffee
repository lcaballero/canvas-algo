{ expect } = require 'chai'
require '../lib/color-extensions'


describe 'Color Extensions =>', ->


  describe 'get rgba components =>', ->

    it 'should return red', ->
      expect([1,2,3].red()).to.equal(1)

    it 'should return green', ->
      expect([1,2,3].green()).to.equal(2)

    it 'should return blue', ->
      expect([1,2,3].blue()).to.equal(3)

    it 'should return alpha', ->
      expect([1,2,3,.4].alpha()).to.equal(.4)


  describe 'set rgb components', ->

    it 'should have set red', ->
      a = [1,2,3,.4]
      b = a.red(111)
      expect(a.red()).to.equal(1)
      expect(b.red()).to.equal(111)

    it 'should have set green', ->
      a = [1,2,3,.4]
      b = a.green(222)
      expect(a.green()).to.equal(2)
      expect(b.green()).to.equal(222)

    it 'should have set green', ->
      a = [1,2,3,.4]
      b = a.blue(333)
      expect(a.blue()).to.equal(3)
      expect(b.blue()).to.equal(333)

    it 'should have set red', ->
      a = [1,2,3,.4]
      b = a.alpha(.8)
      expect(a.alpha()).to.equal(.4)
      expect(b.alpha()).to.equal(.8)


  describe 'toColor =>', ->

    it 'should produce an rgb color', ->
      r = [1,2,3].toColor()
      expect(r).to.equal('rgb(1,2,3)')

    it 'should produce an rgba color', ->
      r = [1,2,3,.4].toColor()
      expect(r).to.equal('rgba(1,2,3,0.4)')

  describe 'toColorArray =>', ->

    it 'should convert #010203', ->
      s = "#010203".toColorArray()
      expect(s.red()).to.be.equal(1)
      expect(s.green()).to.be.equal(2)
      expect(s.blue()).to.be.equal(3)

    it 'should convert #01020304', ->
      s = "#01020304".toColorArray()
      expect(s.red()).to.be.equal(1)
      expect(s.green()).to.be.equal(2)
      expect(s.blue()).to.be.equal(3)
      expect(s.alpha()).to.be.equal(4)

  describe 'remove channels =>', ->

    checkRgb = (c, r, g, b, a) ->
      expect(c.red()    , 'red check').to.equal(r) if r?
      expect(c.green()  , 'green check').to.equal(g) if g?
      expect(c.blue()   , 'blue check').to.equal(b) if b?
      expect(c.alpha()  , 'alpha check').to.equal(a) if a?


    describe 'individual remove channels =>', ->

      it 'should zero red', ->
        c = [1,2,3,.4]
        checkRgb(c.removeRed(), 0, 2, 3, .4)

      it 'should zero green', ->
        c = [1,2,3,.4]
        checkRgb(c.removeGreen(), 1, 0, 3, .4)

      it 'should zero blue', ->
        c = [1,2,3,.4]
        checkRgb(c.removeBlue(), 1, 2, 0, .4)

      it 'should zero alpha', ->
        c = [1,2,3,.4]
        checkRgb(c.removeAlpha(), 1, 2, 3, 1)

    describe 'parameterized remove channel', ->

      it 'should zero red', ->
        c = [1,2,3,.4]
        checkRgb(c.removeChannel('r'), 0, 2, 3, .4)
        checkRgb(c.removeChannel('red'), 0, 2, 3, .4)

      it 'should zero green', ->
        c = [1,2,3,.4]
        checkRgb(c.removeChannel('g'), 1, 0, 3, .4)
        checkRgb(c.removeChannel('green'), 1, 0, 3, .4)

      it 'should zero blue', ->
        c = [1,2,3,.4]
        checkRgb(c.removeChannel('b'), 1, 2, 0, .4)
        checkRgb(c.removeChannel('blue'), 1, 2, 0, .4)

      it 'should zero alpha', ->
        c = [1,2,3,.4]
        checkRgb(c.removeChannel('a'), 1, 2, 3, 1)
        checkRgb(c.removeChannel('alpha'), 1, 2, 3, 1)
