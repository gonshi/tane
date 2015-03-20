CanvasManager = require "./view/canvasManager"
ticker = require( "./util/ticker" )()

socialNetworkInit = ->
  #########################
  # DECLARATION
  #########################
  canvas = new CanvasManager $( ".canvas" )
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
    canvas.resetContext img.width, img.height
    canvas.drawImg img, 0, 0, img.width, img.height,
                          img.width, img.height, 1

    _max = 3
    for i in [ 0..._max ]
      mosaic.push canvas.getMosaic img, 8 * ( _max - i ),
                                          8 * ( _max - i )
    mosaic.push img # the last one

    ticker.listen "mask", ( t )->
      for i in [ 0...mosaic.length ]
        if t * SPEED < img.height * ( i + 1 )
          t -= img.height / SPEED * i
          t = window.easeOutQuad t, 0, img.height, img.height / SPEED
          canvas.clear()
          # 一枚前の画像を全面描画
          if i > 0
            canvas.drawImg mosaic[ i - 1 ], 0, 0,
                                  img.width, img.height,
                                  img.width, img.height,
                                  1 / mosaic.length * i
          canvas.drawImg mosaic[ i ], 0, 0,
                                img.width, t, img.width, t,
                                1 / mosaic.length * ( i + 1 )
          return
      ticker.clear "mask"

  img.src = "img/facebook.jpg?_=#{ Date.now() }"
  ticker.clear()

module.exports = socialNetworkInit
