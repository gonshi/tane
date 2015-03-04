###!
  * Main Function
###

if window._DEBUG
  if Object.freeze?
    window.DEBUG = Object.freeze window._DEBUG
  else
    window.DEBUG = state: true
else
  if Object.freeze?
    window.DEBUG = Object.freeze state: false
  else
    window.DEBUG = state: false

CanvasManager = require "./view/canvasManager"
ticker = require( "./util/ticker" )()
require "./util/easing"

$ ->
  #########################
  # DECLARATION
  #########################
  canvasManager = new CanvasManager $( ".canvas" )
  mosaic = []
  SPEED = 0.4

  #########################
  # EVENT LISTENER
  #########################

  #########################
  # INIT
  #########################

  img = new Image()
  img.onload = ->
    alert "start?"
    canvasManager.resetContext img.width, img.height
    canvasManager.drawImg img, img.width, img.height,
                          img.width, img.height, 1

    _max = 3
    for i in [ 0..._max ]
      mosaic.push canvasManager.getMosaic img, 8 * ( _max - i ),
                                          8 * ( _max - i )
    mosaic.push img # the last one

    ticker.listen "mask", ( t )->
      for i in [ 0...mosaic.length ]
        if t * SPEED < img.height * ( i + 1 )
          t -= img.height / SPEED * i
          t = window.easeOutQuad t, 0, img.height, img.height / SPEED
          canvasManager.clear()
          # 一枚前の画像を全面描画
          if i > 0
            canvasManager.drawImg mosaic[ i - 1 ], img.width, img.height,
                                  img.width, img.height,
                                  1 / mosaic.length * i
          canvasManager.drawImg mosaic[ i ], img.width, t,
                                img.width, t, 1 / mosaic.length * ( i + 1 )
          return
      ticker.clear "mask"

  img.src = "img/facebook.jpg?_=#{ Date.now() }"
