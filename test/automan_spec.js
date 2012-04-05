var expect = chai.expect,
    should = chai.should(),
    assert = chai.assert;

describe("Automan", function() {
  beforeEach(function () {
    jQuery('#test').html('');
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

  describe(".at()", function() {
    var $label = null, $radio = null;

    beforeEach(function() {
      $label = jQuery('<label>').attr('id', 'myLabel').attr('for', 'myRadio').html('My Label');
      $radio = jQuery('<input>').attr('type', 'radio').attr('id', 'myRadio');
      $label.prepend($radio);
      jQuery('#test').append($label);
    });

    it("can click at a specific x/y offset within a given element", function() {
      should.equal($radio.attr('checked'), undefined);

      Automan.at({
        leftOffset: 10,
        topOffset: 10,
        within: '#myLabel'
      });

      $radio.attr('checked').should.equal('checked');
    });
  });

});
