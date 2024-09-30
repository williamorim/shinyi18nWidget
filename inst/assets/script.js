// https://shiny.posit.co/r/articles/build/building-inputs/
var binding = new Shiny.InputBinding();

$.extend(binding, {

  find: function(scope) {
    return $(scope).find(".shiny-i18n-input");
  },

  getValue: function(el) {

      var set = $(el).find(".lang-active");

      var value = $.map(set, function(item) { 
        return $(item).data("value")
      });

      return value;
  },

  subscribe: function(el, callback) {

    var set = $(el).find(".lang-option");

    $(set).on("click", function(e) {
            
        var old = $(el).find(".lang-active");
        $(old).removeClass("lang-active");

        $(e.target).addClass("lang-active");

        callback();

    });

  },

});

Shiny.inputBindings.register(binding);


