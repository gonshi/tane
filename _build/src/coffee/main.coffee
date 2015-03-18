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

ticker = require( "./util/ticker" )()
require "./util/easing"

$ ->
  ##################################
  # DECLARATION
  ##################################

  $pageWrapper = $( ".page_wrapper" )

  init =
    socialNetwork: require "./socialNetworkInit"

  ##################################
  # EVENT LISTENER
  ##################################
 
  $( ".link" ).on "click", ->
    $pageWrapper.hide()
    ticker.clear()

    _data = $( this ).data "link"
    $( ".#{ _data }_wrapper" ).show()
    init[ _data ]()

  ##################################
  # INIT
  ##################################
