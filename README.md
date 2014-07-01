Implementation of sticky headers
=================

The `vs-sticky` module implements sticky headers.

## Installation

```
npm install
bower install
```

## Build

```
npm run build
```

## Testing

```
npm test
```

## Usage

* Create an HTML element containing all the sticky headers. This will be the "header container". This should not be the scrolling DOM container; the header container should move together with the headers while scrolling.

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

## Troubleshooting 

* Sticky headers will be stuck relative to the viewport (normally, this will be the `body` element). The viewport should have a _zero top margin_. A nonzero top margin will create a gap at the top of the viewport, preventing the sticky header from occupying the top position properly.
 
* Another reason for a gap is a non-sticky HTML element at the top of the sticky header container, e.g. a `p` element, that has a nonzero vertical margin.

* All sticky headers should be HTML elements with a solid color background, the same as the background of the surrounding area. Otherwise parts of the document will remain visible beneath the sticky headers.

* All sticky headers should have _zero vertical margins_. All HTML elements _before_ the first sticky header should also have zero vertical margins. If sticky headers (or some elements before them) have nonzero vertical margins (e.g. an `h2` element or a `p` element that have default vertical margins), the typical result is that the vertical margins will sometimes collapse, leading to erratic or jumping behavior of the sticky headers while scrolling. Use zero vertical margins and nonzero padding, for the desired effect (padding creates non-collapsible margins).


## Example

`examples/example1-simple-scroll.html` shows a simple self-contained usage example.

To test: open this file in the browser.

