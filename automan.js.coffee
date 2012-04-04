Automan =
  #### Private things

  # Automan's wrapper for `console.log`
  _log: (args...) ->
    args.unshift('Automan')
    console?.log(args...)

  # Not implemented yet. Maybe not even possible.
  #
  #     screenX = undefined
  #     screenY = undefined
  #     evt = document.createEvent("TouchEvent")
  #     evt.initTouchEvent(eventType, true, true, window, 0, screenX, screenY, clientX, clientY, false, false, false, false, 0, null)
  #     el.dispatchEvent(evt)
  _dispatchTouchEvent: (eventType, clientX, clientY, el) ->

  # Dispatches a mouse event of a given type, given an X/Y coordinate
  # from the top, left corner of the given element.
  _dispatchMouseEvent: (mouseEventType, clientX, clientY, el) ->
    screenX = undefined
    screenY = undefined
    evt = document.createEvent("MouseEvents")
    evt.initMouseEvent(mouseEventType, true, true, window, 0, screenX, screenY, clientX, clientY, false, false, false, false, 0, null)
    el.dispatchEvent(evt)

  # Determines X/Y coordinates relative to the window (client), given
  # a jQuery element and coordinates relative to that element. E.g.:
  #
  #     [x, y] = @_coordsWithOffset(
  #       leftOffset,
  #       topOffset,
  #       jQueryElement
  #     )
  _coordsWithOffset: (leftOffset, topOffset, $el) ->
    {top, left} = $el.offset()
    y = top + topOffset
    x = left + leftOffset
    [x, y]

  #### Main User Interaction Simulation Functions

  # Click on a DOM element, given its selector. E.g.:
  #
  #     Automan.on('#myElement')
  on: (selector) ->
    jQuery(selector).trigger('click')
    @

  # Enhances human-readability of chained Automan events. E.g.:
  #
  #     Automan
  #       .on("#myElement")
  #       .then()
  #       .on("#myOtherElement")
  then: -> @

  # Simulate a click on a given element at the specified coordinates. Coordinates
  # should originate from the top left of the `within` element. `within` should be
  # a CSS selector. E.g.:
  #
  #     Automan.at({
  #       leftOffset: 150,
  #       topOffset: 150,
  #       within: '#someContainer'
  #     })
  at: (options) ->
    {leftOffset, topOffset, within} = options

    if leftOffset == 0 || topOffset == 0
      @_log('WARN: offset was 0, maybe you should double-check it?', 'leftOffset', leftOffset, 'topOffset', topOffset)

    $within = jQuery(within)
    [clientX, clientY] = @_coordsWithOffset(leftOffset, topOffset, $within)

    el = $within.get(0)

    # Fire all events that occur when a mouse is clicked or a touch
    # screen is tapped.
    @_dispatchTouchEvent('touchstart', clientX, clientY, el)
    @_dispatchMouseEvent('mousedown', clientX, clientY, el)
    @_dispatchTouchEvent('touchend', clientX, clientY, el)
    @_dispatchMouseEvent('mouseup', clientX, clientY, el)
    @

  # Simulate a drag event on a given element, from one set of coordinates to
  # another. Coordinates should originate at the top left corner of the `within`
  # element.
  #
  #     Automan.drag({
  #       from: [15, 15],
  #       to: [150, 150],
  #       within: '#someContainer'
  #     });
  drag: (options) ->
    {from, to, within} = options

    $within = jQuery(within)

    [startX, startY] = @_coordsWithOffset(from[0], from[1], $within)
    [endX, endY] = @_coordsWithOffset(to[0], to[1], $within)

    el = $within.get(0)

    # Dispatch all of the events fired during a click and drag
    # (i.e. drag and drop). Note that `mousemove` is fired at
    # the start point and the end point, but not at any points
    # in between.
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
