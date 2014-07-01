describe "VsSticky", () ->
  beforeEach ->
    $('body').append """
      <style>
      .sticky-header-container {
        position: relative;
        z-index: 0;
        height: 10000px;
      }
      .sticky-header-padding  {
        height: 100px;
      }
      .vertical-padding {
        height: 100px;
      }
      body {
        margin:0;
      }
      </style>
      <div class="sticky-header-container">
        <div id="header1" class="sticky-header-padding js-sticky-header">header1</div>
        <div class="vertical-padding"></div>
        <div id="header2" class="sticky-header-padding js-sticky-header">header2</div>
        <div class="vertical-padding"></div>
        <div id="header3" class="sticky-header-padding js-sticky-header">header3</div>
        <div class="vertical-padding"></div>
        <div id="header4" class="sticky-header-padding js-sticky-header">header4</div>
        <div class="vertical-padding"></div>

      </div>
      """

  afterEach ->
    $('body').html ''

  it "headers have correct positions before scrolling", ->
    header2PositionTopOld = $('#header2').position().top
    chai.expect(header2PositionTopOld).to.equal 200

  it "wraps sticky header upon scroll", (done) ->
    vsSticky = new VsSticky($('.sticky-header-container'))
    $(window).scrollTop(350);
    _.defer ->
      header2PositionTop = $('#header2').position().top
      chai.expect(header2PositionTop).to.equal -50
      done()
