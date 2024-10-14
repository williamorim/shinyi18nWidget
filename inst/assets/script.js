var binding = new Shiny.InputBinding();

$.extend(binding, {

  find: function(scope) {
    return $(scope).find(".shiny-i18n-input");
  },

  getValue: function(el) {

      var value = $(el).data("value");

      return value;
  },

  setValue: function(el, value) {
    $(el).data("value", value);
  },

  subscribe: function(el, callback) {

    var set = $(el).find(".lang-option");

    $(set).on("click", function(e) {
            
        var old = $(el).find(".lang-active");
        $(old).removeClass("lang-active");

        $(e.target).addClass("lang-active");

        $(el).data("value", $(e.target).attr("value"));

        callback();

    });

  },

  receiveMessage: function(el, data) {
    if (data.hasOwnProperty('value'))
      this.setValue(el, data.value);

    var set = $(el).find(".lang-option");

    $(set).each(function(i, e) {
      if ($(e).attr("value") == data.value) {
        $(e).trigger("click");
      }
    });
  },

});

Shiny.inputBindings.register(binding, 'shiny.i18nInput');


