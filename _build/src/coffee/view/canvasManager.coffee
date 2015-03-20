class CanvasManager
  constructor: ( $dom )->
    @$canvas = $dom
    @canvas = @$canvas.get 0
    if !@canvas.getContext
      return undefined
    @ctx = @canvas.getContext "2d"

  resetContext: ( width, height )->
    @canvas.width = width
    @canvas.height = height
    @$canvas.width width
    @$canvas.height height

  clear: -> @ctx.clearRect 0, 0, @canvas.width, @canvas.height

  drawImg: ( img, x, y, sw, sh, dw, dh, opacity )->
    @ctx.globalCompositeOperation = "source-over"
    @ctx.globalAlpha = opacity
    @ctx.drawImage img, 0, 0, sw, sh, x, y, dw, dh

  drawIn: ( img, x, y )->
    @ctx.save()
    @ctx.globalCompositeOperation = "source-in"
    @ctx.drawImage img, x, y
    @ctx.restore()

  getMosaic: ( img, x_rough, y_rough )->
    _imgData = @ctx.createImageData img.width, img.height
    _originImgData = @getImgData( 0, 0, img.width, img.height ).data

    for x in [ 0...img.width ]
      for y in [ 0...img.height ]
        for i in [ 0...4 ]
          _imgData.data[ ( x + img.width * y ) * 4 + i ] =
            _originImgData[ ( ( Math.floor( x / x_rough ) * x_rough ) +
            x_rough / 2 + ( Math.floor( y / y_rough ) * y_rough +
            y_rough / 2 ) * img.width ) * 4 + i ]
    _originImgData = null
    _canvas = document.createElement "canvas"
    _canvas.width = @canvas.width
    _canvas.height = @canvas.height
    _ctx = _canvas.getContext( "2d" )
    _canvas.getContext( "2d" ).putImageData _imgData, 0, 0
    return _canvas

  # for opacityGradient
  # 横向きに、左半分はベタ塗り、
  # 右半分はグラデーションの画を描画します
  getGradient: ( width, height )->
    _canvas = document.createElement "canvas"
    _canvas.width = width
    _canvas.height = height
    _ctx = _canvas.getContext( "2d" )
    _ctx.beginPath()
    _grad = _ctx.createLinearGradient 0, 0, width, 0
    _grad.addColorStop 0, "rgba(0, 0, 0, 1)"
    _grad.addColorStop 0.5, "rgba(0, 0, 0, 1)"
    _grad.addColorStop 1, "rgba(0, 0, 0, 0)"
    _ctx.fillStyle = _grad
    _ctx.rect 0, 0, width, height
    _ctx.fill()
    return _canvas

  getImgData: ( x, y, width, height )->
    @ctx.getImageData x, y, width, height

  getImg: -> @canvas.toDataURL()

  getContext: -> @ctx

module.exports = CanvasManager
