Implementation of sticky headers
=================

The `vs-sticky` module implements sticky headers.

## Requirements

The module is loaded via `require.js` and depends on `underscore.js`, `jquery.js`.

## Usage

Create an HTML element containing all the sticky headers. This will be the "container". Each sticky header should have a certain CSS class; by default, this is `js-sticky-header`, but this can be changed.

Create an object of class `VsSticky` and initialize it with the `jQuery`-constructed DOM element.

```
var $container = $('div.sticky-header-container');
var controller = new VsSticky($container);
```

Creating a "controller" object is sufficient.


If the CSS class on sticky headers is not `js-sticky-header`, specify the name of that CSS class in the `VsSticky` constructor. This can be an arbitrary `jQuery`-compatible CSS selector:

```
var controller = new VsSticky($container, 'h3.my-sticky-header-selector');
```

## Example

`examples/example1-simple-scroll.html` shows a simple self-contained usage example.

To test: open this file in the browser.
