class window.StickyHeaders
  STUCK_Z_INDEX: 98 # above .gadget-drop-target as defined in lesson.styl

  constructor: (@$container, @selector = '.js-sticky-header') ->
    @scanContainer()

    @_throttledScroll = _.throttle @_scroll, 10
#      // note: the scroll container must be the active one. By default, this is "window", but this won't work if we put overflow=... on another element.
    # in that case, we would have to add another argument to the constructor, to pass the active scroll container.
    # On the other hand, the "container" argument must be a DOM element that scrolls together with the headers; not the scroll container.
    $(window).on 'scroll', @_throttledScroll
    @_watchInterval = setInterval @_watchContainer, 730

  destroy: ->
    @_changeCurrentSection null

    $(window).off 'scroll', @_throttledScroll
    clearInterval @_watchInterval

  scanContainer: ->
    @_containerTop = @$container.offset().top
    @_containerHeight = @$container.height()

    @_changeCurrentSection null
    @_sections = []

    $headers = @$container.find @selector
    for i in [0...$headers.length]
      $header = $($headers[i])
      $header.css position: 'relative'

      @_sections.push
        top: $header.offset().top
        headerHeight: $header.outerHeight()
        $header: $header

      if i > 0
        prevSection = @_sections[i-1]
        prevSection.bottom = $header.offset().top

    _.last(@_sections)?.bottom = @$container.height()

    @_scroll()

  _inCurrentSection: (y) ->
    return false unless @_currentSection?

    @_currentSection.top <= y < @_currentSection.bottom

  _findSectionByCutoff: (y) ->
    _.find @_sections, (section) -> section.top <= y < section.bottom

  _setHeaderOffset: (section, y) ->
    return unless @_currentSection?

    headerOffset = y + section.headerHeight - section.bottom
    effectiveHeaderOffset = if headerOffset > 0 then @_containerTop-headerOffset else @_containerTop
    section.$header.css 'top', effectiveHeaderOffset

  _scroll: =>
    cutoff = $(window).scrollTop() + @_containerTop #y-position of top of lesson

    unless @_inCurrentSection cutoff
      @_changeCurrentSection @_findSectionByCutoff cutoff

    @_setHeaderOffset @_currentSection, cutoff

  _changeCurrentSection: (section) ->
    @_unwrap(@_currentSection) if @_currentSection?
    @_wrap(section) if section?

    @_currentSection = section

  _wrap: (section) ->
    section.$header.css
      left: section.$header.offset().left # fix to original x-position
      top: @_containerTop

    # Placeholder to reserve space where the original header was
    placeholder = $('<div/>').height section.headerHeight
    section.$header
      .wrap(placeholder)
      .css
        'z-index': @STUCK_Z_INDEX
        position: 'fixed'
        width: '100%'

  _unwrap: (section) ->
    section.$header
      .removeAttr('style')
      .unwrap()

  _watchContainer: =>
    @scanContainer() if (@_containerTop != @$container.offset().top ||
      @_containerHeight != @$container.height())
