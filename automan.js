(function() {

  window.Automan = {
    // Private Things
    // -----------------------

    // Automan's wrapper for `console.log`
    _log: function() {
      var __slice = Array.prototype.slice;
      var args = (1 <= arguments.length) ? __slice.call(arguments, 0) : [];
      args.unshift('Automan');
      if (typeof console !== "undefined" && console !== null) {
        console.log.apply(console, args);
      }
      return this;
    },

    // Dispatches a mouse event of a given type, given an X/Y coordinate
    // from the top, left corner of the given element.
    _dispatchMouseEvent: function(mouseEventType, clientX, clientY, el) {
      var evt = document.createEvent('MouseEvents'), screenX, screenY;

      evt.initMouseEvent(mouseEventType, true, true, window, 0, screenX, screenY, clientX, clientY, false, false, false, false, 0, null);
      return el.dispatchEvent(evt);
    },

    // Determines X/Y coordinates relative to the window (client), given
    // a jQuery element and coordinates relative to that element.
    _coordsWithOffset: function(leftOffset, topOffset, $el) {
      var offset = $el.offset();
      var x = offset.left + leftOffset,
          y = offset.top + topOffset;

      return [x, y];
    },

    // Useful for debugging. Attaches click, mousedown, mousemove, and mouseup
    // event observers to `<body>`
    _debugRealEvents: function() {
      var that = this;
      var log = function(e) { return that._log(e.type, e); };

      jQuery('body').click(log);
      jQuery('body').mousedown(log);
      jQuery('body').mousemove(function(e) { return that._log(e.type); });
      jQuery('body').mouseup(log);
      return this;
    },

    // Main User Interaction Simulation Functions
    // ------------------------------------------

    // Click on a DOM element, given its selector. E.g.:
    //
    //     Automan.on('#myElement');
    on: function(selector) {
      jQuery(selector).trigger('click');
      return this;
    },

    // Enhances human-readability of chained Automan events. E.g.:
    //
    //     Automan
    //       .on("#myElement")
    //       .then()
    //       .on("#myOtherElement");
    then: function() { return this; },

    // Simulate a click on a given element at the specified coordinates. Coordinates
    // should originate from the top left of the `within` element. `within` should be
    // a CSS selector. E.g.:
    //
    //     Automan.at({
    //       leftOffset: 150,
    //       topOffset: 150,
    //       within: '#someContainer'
    //     });
    at: function(options) {
      var $within = jQuery(options.within),
          leftOffset = options.leftOffset,
          topOffset = options.topOffset;

      var coords = this._coordsWithOffset(leftOffset, topOffset, $within);

      var clientX = coords[0],
          clientY = coords[1],
          el = $within.get(0);

      if (leftOffset === 0 || topOffset === 0) {
        this._log('WARN: offset was 0, maybe you should double-check it?', 'leftOffset', leftOffset, 'topOffset', topOffset);
      }

      this._dispatchMouseEvent('mousedown', clientX, clientY, el);
      this._dispatchMouseEvent('mouseup', clientX, clientY, el);
      this._dispatchMouseEvent('click', clientX, clientY, el);
      return this;
    },

    // Simulate a drag event on a given element, from one set of coordinates to
    // another. Coordinates should originate at the top left corner of the `within`
    // element.
    //
    //     Automan.drag({
    //       from: [15, 15],
    //       to: [150, 150],
    //       within: '#someContainer'
    //     });
    drag: function(options) {
      var $within = jQuery(options.within),
          from = options.from,
          to = options.to;

      var fromCoords = this._coordsWithOffset(from[0], from[1], $within),
          toCoords = this._coordsWithOffset(to[0], to[1], $within);

      var el = $within.get(0),
          startX = fromCoords[0],
          startY = fromCoords[1],
          endX = toCoords[0],
          endY = toCoords[1];

      this._dispatchMouseEvent("mousedown", startX, startY, el);
      this._dispatchMouseEvent("mousemove", startX, startY, el);
      this._dispatchMouseEvent("mousemove", endX, endY, el);
      this._dispatchMouseEvent("mouseup", endX, endY, el);
      return this;
    }
  };

}).call(this);
