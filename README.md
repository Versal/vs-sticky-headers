Implementation of sticky headers
=================

The `vs-sticky` module implements sticky headers.

## Requirements

The module is loaded via `require.js` and depends on `underscore.js`, `jquery.js`.

## Usage

* Create an HTML element containing all the sticky headers. This will be the "header container". This should not be the scrolling DOM container; the header container should move together with the headers while scrolling. Sticky headers will be stuck relative to the viewport.

* All sticky headers should be HTML elements _without vertical margins_ and should have solid color background, the same as the background of the surrounding area.

* All sticky headers should be selectable by a certain CSS selector.
By default, this selector is `.js-sticky-header`, but this can be changed (see below).

* Create an object of class `VsSticky` and initialize it with the `jQuery`-constructed DOM element.

```
var $container = $('div.sticky-header-container');
var controller = new VsSticky($container); // using the default CSS selector
```

Creating a "controller" object is sufficient. The sticky headers will be initialized and rescanned.


If the CSS class on sticky headers is not `js-sticky-header`, specify the name of that CSS class in the `VsSticky` constructor. This can be an arbitrary `jQuery`-compatible CSS selector:

```
var controller = new VsSticky($container, 'h3.my-sticky-header-selector');
```

## Example

`examples/example1-simple-scroll.html` shows a simple self-contained usage example.

To test: open this file in the browser.

