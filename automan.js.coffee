Automan =
  _log: (args...) ->
    args.unshift('Automan')
    console?.log(args...)

  _dispatchTouchEvent: (eventType, clientX, clientY, el) ->
    # @_log("Touch Event #{eventType} attempted to fire.  NYE")
    # console.log(arguments)
    # screenX = undefined
    # screenY = undefined
    # evt = document.createEvent("TouchEvent")
    # evt.initTouchEvent(eventType, true, true, window, 0, screenX, screenY, clientX, clientY, false, false, false, false, 0, null)
    # el.dispatchEvent(evt)

  _dispatchMouseEvent: (mouseEventType, clientX, clientY, el) ->
    screenX = undefined
    screenY = undefined
    evt = document.createEvent("MouseEvents")
    evt.initMouseEvent(mouseEventType, true, true, window, 0, screenX, screenY, clientX, clientY, false, false, false, false, 0, null)
    el.dispatchEvent(evt)

  _coordsWithOffset: (leftOffset, topOffset, $el) ->
    {top, left} = $el.offset()
    y = top + topOffset
    x = left + leftOffset
    [x, y]

  on: (selector) ->
    jQuery(selector).trigger('click')
    @

  then: -> @

  at: (options) ->
    {leftOffset, topOffset, within} = options

    if leftOffset == 0 || topOffset == 0
      @_log('WARN: offset was 0, maybe you should double-check it?', 'leftOffset', leftOffset, 'topOffset', topOffset)

    $within = jQuery(within)
    [clientX, clientY] = @_coordsWithOffset(leftOffset, topOffset, $within)

    el = $within.get(0)

    @_dispatchTouchEvent('touchstart', clientX, clientY, el)
    @_dispatchMouseEvent('mousedown', clientX, clientY, el)
    @_dispatchTouchEvent('touchend', clientX, clientY, el)
    @_dispatchMouseEvent('mouseup', clientX, clientY, el)
    @

  drag: (options) ->
    {from, to, within} = options

    $within = jQuery(within)

    [startX, startY] = @_coordsWithOffset(from[0], from[1], $within)
    [endX, endY] = @_coordsWithOffset(to[0], to[1], $within)

    el = $within.get(0)
    @_dispatchTouchEvent("touchstart", startX, startY, el)
    @_dispatchMouseEvent("mousedown", startX, startY, el)
    @_dispatchTouchEvent("touchmove", startX, startY, el)
    @_dispatchMouseEvent("mousemove", startX, startY, el)
    @_dispatchTouchEvent("touchmove", endX, endY, el)
    @_dispatchMouseEvent("mousemove", endX, endY, el)
    @_dispatchTouchEvent("touchend", endX, endY, el)
    @_dispatchMouseEvent("mouseup", endX, endY, el)
    @

window.Automan = Automan
