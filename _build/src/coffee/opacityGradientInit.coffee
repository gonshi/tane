CanvasManager = require "./view/canvasManager"
ticker = require( "./util/ticker" )()

opacityGradientInit = ->
  #########################
  # DECLARATION
  #########################
  
  canvas = new CanvasManager $( ".opacityGradient_wrapper .canvas" )

  imgWidth = null
  imgHeight = null
  DRAW_WIDTH = 600
  DRAW_HEIGHT = null
  SPEED = 1
  gradient = null

  img = new Image()
  img.onload = ->
    imgWidth = img.width
    imgHeight = img.height
    DRAW_HEIGHT = imgHeight * ( DRAW_WIDTH / imgWidth )
    canvas.resetContext DRAW_WIDTH, DRAW_HEIGHT
    gradient = canvas.getGradient( DRAW_WIDTH * 2, DRAW_HEIGHT )
  img.src = "img/bg.jpg?_#{ Date.now() }"

  #########################
  # EVENT LISTENER
  #########################
  
  setTimeout ->
    ticker.listen "LOADING", ->
      if imgWidth != null
        ticker.clear "LOADING"
        ticker.listen "DRAW_IMG", ( t )->
          _t = window.easeOutQuad t, 0, 100, DRAW_WIDTH * 2 / SPEED
          canvas.clear()
          if t > DRAW_WIDTH * 2 / SPEED
            ticker.clear "DRAW_IMG"
            _x = 0
          else
            _x = _t / 100 * DRAW_WIDTH * 2 - DRAW_WIDTH * 2

          canvas.drawImg gradient, _x, 0,
                        DRAW_WIDTH * 2, DRAW_HEIGHT,
                        DRAW_WIDTH * 2, DRAW_HEIGHT, 1
          canvas.drawIn img, 0, 0
  , 500

  #########################
  # INIT
  #########################
  canvas.clear()

module.exports = opacityGradientInit
