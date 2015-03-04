class CanvasManager
  constructor: ( $dom )->
    @$canvas = $dom
    @canvas = @$canvas.get 0
    if !@canvas.getContext
      return undefined
    @context = @canvas.getContext "2d"

  resetContext: ( width, height )->
    @canvas.width = width
    @canvas.height = height
    @$canvas.width width
    @$canvas.height height

  clear: -> @context.clearRect 0, 0, @canvas.width, @canvas.height

  drawImg: ( img, sw, sh, dw, dh, opacity )->
    @context.globalCompositeOperation = "source-over"
    @context.globalAlpha = opacity
    @context.drawImage img, 0, 0, sw, sh, 0, 0, dw, dh

  getMosaic: ( img, x_rough, y_rough )->
    _imgData = @context.createImageData img.width, img.height
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
    _context = _canvas.getContext( "2d" )
    _canvas.getContext( "2d" ).putImageData _imgData, 0, 0
    return _canvas

  getImgData: ( x, y, width, height )->
    @context.getImageData x, y, width, height

  getImg: -> @canvas.toDataURL()

  getContext: -> @context

module.exports = CanvasManager
