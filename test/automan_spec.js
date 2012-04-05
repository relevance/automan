var expect = chai.expect,
    should = chai.should(),
    assert = chai.assert;

describe("Automan", function() {
  beforeEach(function () {
    var e = document.getElementById('test'),
    p = e.parentNode;

    p.removeChild(e);

    e = document.createElement("div");
    e.id = "test";

    p.appendChild(e);
  });

  describe(".on()", function() {
    var clicked = false;

    beforeEach(function() {
      var $el;
      $el = jQuery('<div>').attr('id', 'myElement');
      $el.click(function() {
        clicked = true;
      });
      jQuery('#test').append($el);
    });

    it("should click on an element", function() {
      clicked.should.be["false"];
      Automan.on('#myElement');
      clicked.should.be["true"];
    });
  });
});
