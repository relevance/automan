    _______         _____                                    
    ___    |____  ____  /_______ _______ ___ ______ ________ 
    __  /| |_  / / /_  __/_  __ \__  __ `__ \_  __ `/__  __ \
    _  ___ |/ /_/ / / /_  / /_/ /_  / / / / // /_/ / _  / / /
    /_/  |_|\__,_/  \__/  \____/ /_/ /_/ /_/ \__,_/  /_/ /_/

This Javascript library provides user interaction simulations via a
simple API. Beyond the expected "click on element" functions, it allows
you to specify *where* an element was clicked or dragged.

## Features

* **Click on specified element** given its CSS selector.

```javascript
Automan.on('#myElement');
```

* **Chained interactions.** Click on this, then click on that!

```javascript
Automan.on("#myElement").then().on("#myOtherElement");
```

* **Click at a specified location** given a CSS selector and a top and
  left offset.

```javascript
Automan.at({
  leftOffset: 150,
  topOffset: 150,
  within: '#someContainer'
});
```

* **Click and drag** within an element, given its CSS selector and
  start/end coordinates (offset from top/left of the given element).

```javascript
Automan.drag({
  from: [15, 15],
  to: [150, 150],
  within: '#someContainer'
});
```

## Local setup

    npm install .

## Running the tests

If you already have coffee-script/cake installed it should be as simple as:

    cake test

If not, you'll need to install cake via npm. We suggest  running `npm install -g coffee-script` to make cake available on your path.
