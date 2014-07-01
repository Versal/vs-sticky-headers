  _vendorPrefixes = ['', '-webkit-', '-moz-', '-ms-', '-o-']

  class window.StickyHeaders
    selector: '.js-sticky-header'

    constructor: (@el) ->
      @_throttledScroll = _.throttle @onScroll, 10
      @_current = null
      @_stickyContainer = $('<div class="vs-sticky-container" />')
      @enable()

    enable: ->
      $(@el).on 'scroll', @_throttledScroll

    disable: ->
      $(@el).off 'scroll', @_throttledScroll

    onScroll: =>
      cutoff = @el.getBoundingClientRect().top
      candidates = @el.querySelectorAll @selector
      return unless candidates.length

      { current, next } = _.reduce candidates, _.partial(@findCurrent, cutoff), null
      if @_sticky != current then @setStickyHeader current
      @adjustCurrent cutoff, current, next

    findCurrent: (cutoff, memo, cur) ->
      memo ?= { current: null, next: null }
      unless memo.next
        memo.current = cur if cur.getBoundingClientRect().top <= cutoff
        if memo.current != cur then memo.next = cur
      return memo

    setStickyHeader: (current) ->
      @_sticky = current
      return @_stickyContainer.detach() unless current
      @_stickyContainer
        .text(current.textContent)
        .appendTo @el

    adjustCurrent: (cutoff, current, next) ->
      return unless current
      remainingSpace = (next?.getBoundingClientRect().top || @el.getBoundingClientRect().bottom) - cutoff
      offset = remainingSpace - current.getBoundingClientRect().height
      transform = if offset <= 0 then "translateY(#{offset}px)" else 'none'
      $(@_stickyContainer).css _.object _.map(_vendorPrefixes, (pref) -> ["#{pref}transform", transform])
