$(function() {
  // Enable float labels on input
  var toggleFloatLabel = function() {
    // Create variables
    var inputCardId = document.getElementById("pck-card-id");
    var inputCardPin = document.getElementById("pck-card-pin");
    var inputEmail = document.getElementById("billing_email");
    var activeClassName = "input-float__label--has-text";
    var floatLabelCardId = document.querySelector("label[for=pck-card-id]");
    var floatLabelCardPin = document.querySelector("label[for=pck-card-pin]");
    var floatLabelEmail = document.querySelector("label[for=billing_email]");

    // Validate existence & add event listenener
    if (inputCardId != null) {
      inputCardId.addEventListener("input", function() {
        if (inputCardId.value.length > 0) {
          floatLabelCardId.classList.add(activeClassName);
        }
        else {
          if (inputCardId.value.length < 1) {
            floatLabelCardId.classList.remove(activeClassName);
          }
        }
      });
    }

    if (inputCardPin != null) {
      inputCardPin.addEventListener("input", function() {
        if (inputCardPin.value.length > 0) {
          floatLabelCardPin.classList.add(activeClassName);
        }
        else {
          if (inputCardPin.value.length < 1) {
            floatLabelCardPin.classList.remove(activeClassName);
          }
        }
      });
    }

    if (inputEmail != null) {
      inputEmail.addEventListener("input", function() {
        if (inputEmail.value.length > 0) {
          floatLabelEmail.classList.add(activeClassName);
        }
        else {
          if (inputEmail.value.length < 1) {
            floatLabelEmail.classList.remove(activeClassName);
          }
        }
      });
    }
  };
  toggleFloatLabel();

  // IE fix.
  if (document.documentElement.setAttribute && navigator.userAgent) {
    document.documentElement.setAttribute(
      "data-useragent",
      navigator.userAgent
    );
  }

  // Safari fix. Safari shows a cached version on back, so make sure the shroud is gone and all buttons are enabled on pageshow.
  $(window).on("pageshow", function(event) {
    $(".body--shroud").remove();
    $("#footer .button, #cancel-button .button")
      .removeClass("disabled")
      .prop("disabled", false);
  });

  // Enable hints.
  $(".hint__toggle").each(function() {
    new Hint($(this));
  });

  // Enable language toggle.
  $("#select-locale").change(function() {
    $(this)
      .parents("form")
      .submit();
  });

  // Always disable the action button.
  $("form").on("submit", function() {
    $("form#body").append('<div class="body--shroud"></div>');

    // Disable buttons too, but only after a short timeout, otherwise their names are not submitted with the form request.
    setTimeout(function() {
      $("#footer .button, #cancel-button .button")
        .addClass("disabled")
        .prop("disabled", true);
    }, 10);
  });
  var grid_buttons = $(".buttons-grid button");
  grid_buttons.removeClass("active").click(function() {
    grid_buttons.removeClass("active");
    $(this).addClass("active");
  });

  // Form validation.
  var form = $("form#body");
  var revalidate_form = function() {
    if (form.find(":invalid, .input--invalid").length) {
      form.addClass("form-invalid");
      form.removeClass("form-valid");
    }
    else {
      form.removeClass("form-invalid");
      form.addClass("form-valid");
    }
  };
  revalidate_form();

  // Autofocus first input.
  setTimeout(function() {
    var input = form
      .find(".input--invalid")
      .find("input:visible, textarea")
      .eq(0);
    if (!input.length) {
      input = form.find("input:visible, textarea").eq(0);
    }
    if (input.length) {
      var v = input.focus().val();
      input.val("");
      input.val(v);
    }
  }, 50);

  // Highlight inputs that are valid or invalid.
  form
    .find("input:visible, textarea")
    .on("change keypress input blur cut paste", function(e) {
      var _this = $(this);
      var wrapper = _this.parents(".input-float__wrapper");
      var immediate = e.type == "blur" || wrapper.hasClass("input--invalid");
      var minLength = _this.data("min-length") || 1;
      var notEquals = "" + _this.data("not-equals");
      if (_this.attr("type") == "checkbox" || _this.attr("type") == "radio") {
        return;
      }

      wrapper.removeClass("input--valid");
      if (_this.val().length < minLength) {
        if (e.type != "blur") {
          wrapper.removeClass("input--invalid");
        }
      }
      else {
        if (this._timeout) {
          clearTimeout(this._timeout);
        }
        this._timeout = setTimeout(
          function() {
            if (
              !wrapper.hasClass("input--valid") &&
              _this.is(":valid") &&
              _this.val() !== notEquals
            ) {
              if (
                _this.attr("id") == "sdd-bank-account" &&
                !validateIso7064Checksum(_this.val())
              ) {
                return;
              }

              wrapper.removeClass("input--invalid");
              wrapper.addClass("input--valid");
            }

            if (
              (
                !wrapper.hasClass("input--invalid") &&
                _this.is(":invalid") &&
                e.type === "blur"
              ) ||
              _this.val() === notEquals
            ) {
              wrapper.addClass("input--invalid");
              wrapper.removeClass("input--valid");
            }
          },
          immediate ? 0 : 1000
        );
      }

      revalidate_form();
    })
    .trigger("blur");

  // Full height background in the glass container.
  var resize_wallpaper = function() {
    $(".header--blurred-wallpaper").css({
      height: $(document).height()
    });
  };

  resize_wallpaper();
  $(window).on("resize", resize_wallpaper);

  // Setup the card slider on the One Click screen.
  if ($("#one-click-cards-slider").length) {
    new CardSlider(
      $("#one-click-cards-wrapper"),
      $(".one-click-card"),
      $("#one-click-cards-nav").find("div")
    );
  }

  // Send Belfius customer to Belfius Pay Button directly.
  var $belfius_button = $("#belfius-backup-button");
  if ($belfius_button.length) {
    $belfius_button.click();
    $(".footer").hide();
    $(".wait").removeClass("hide");
  }

  // PODIUM Cadeaukaart card number validation.
  $("#pck-card-id")
    .on("focus", function() {
      var val = $(this)
        .val()
        .replace(/[^0-9 ]/g, "");
      $(this).val(val);
    })
    .on("blur change cut", function() {
      var val = $(this)
        .val()
        .replace(/[^0-9]/g, "")
        .replace(/([0-9]{4})/g, "$1 ")
        .trim()
        .substr(0, 23);
      $(this).val(val);
    });

  // SEPA Direct Debit bankaccount formatting.
  $("#sdd-bank-account")
    .on("focus", function() {
      var val = $(this)
        .val()
        .toUpperCase()
        .replace(/[^0-9A-Z ]/g, "");
      $(this).val(val);
    })
    .on("blur change cut", function() {
      var val = $(this)
        .val()
        .toUpperCase()
        .replace(/[^0-9A-Z]/g, "")
        .replace(/([0-9A-Z]{4})/g, "$1 ")
        .trim();
      $(this).val(val);
    });

  /**
   * Let a hint appear when $hint_toggle is clicked or tapped on.
   *
   * @param $hint_toggle
   */

  function Hint($hint_toggle) {
    var self = this;
    var reference = $hint_toggle.data("hint");
    var $hint = $(".hint[data-hint='" + reference + "']");

    this.__construct = function() {
      $hint_toggle.click(self.toggleHint);
    };

    this.toggleHint = function() {
      $hint.toggleClass("hide");
    };

    this.__construct();
  }

  /**
   * Have $timer count down for a given number of seconds, and then refresh the page.
   *
   * @param $timer
   * @param seconds
   */
  function Countdown($timer, seconds) {
    var self = this,
      date_created = $timer.data("created"),
      template = $timer.data("template");
    this.__construct = function() {
      setInterval(self.tick, 500);
    };

    this.tick = function() {
      var time_remaining = seconds -
        (
          +new Date() / 1000 - date_created
        );
      if (time_remaining <= 0) {
        self.reloadWindow();
      }

      var minutes_remaining = Math.floor(time_remaining / 60),
        seconds_remaining = Math.floor(time_remaining % 60);
      $timer.text(
        template
          .replace("^1", minutes_remaining)
          .replace("^2", seconds_remaining)
      );
    };

    this.reloadWindow = function() {
      $(window).unbind("beforeunload");
      window.location.reload(true);
    };

    this.__construct();
  }

  /**
   * Poll the given endpoint according to the retry schema and handle the poll response with a callback.
   *
   * @param polling_endpoint
   * @param retry_schema
   * @param callback
   */
  function Poller(polling_endpoint, retry_schema, callback) {
    var self = this,
      current_attempt = 0;
    this.__construct = function() {
      self.poll();
    };

    this.poll = function() {
      // Poll.
      $.get(polling_endpoint)
        .promise()
        .done(callback);
      current_attempt++;
      var retry_timeout = null;

      // Check the schema if we're allowed to poll again.
      for (var attempts in retry_schema) {
        if (current_attempt < attempts) {
          retry_timeout = retry_schema[attempts];
          break;
        }
      }

      if (retry_timeout) {
        setTimeout(self.poll, retry_timeout);
      }
    };

    this.__construct();
  }

  function CardSlider($card_wrapper, $cards, $navigation_bullets) {
    var self = this,
      $current_card = null,
      initial_wrapper_offset = 0,
      current_wrapper_offset = 0,
      initial_drag_offset = 0,
      current_drag_offset = 0,
      has_dragged = false,
      card_width = 0,
      min_offset = 0,
      max_offset = 0,
      slide_threshold = 40;
    this.__construct = function() {
      if (!$cards.length) {
        return;
      }

      $card_wrapper.on("mousedown touchstart", self.startDrag);
      var $first_card = $cards.eq(0);

      // Initialize a few class properties.
      card_width = $first_card.outerWidth(true);
      min_offset =
        -(
          card_width *
          (
            $cards.length - 1
          )
        );

      // Activate the first card.
      self.snapToCard($first_card);
      $cards.on("click", self.selectCard);
      $navigation_bullets.on("click", self.selectBullet);
      $(window).on("keydown", function(e) {
        if (e.keyCode >= 49 && e.keyCode < 59) {
          $navigation_bullets.eq(e.keyCode - 49).trigger("click");
        }

        if (e.keyCode == 37) {
          $navigation_bullets
            .filter(".active")
            .prev()
            .trigger("click");
        }
        else {
          if (e.keyCode == 39) {
            $navigation_bullets
              .filter(".active")
              .next()
              .trigger("click");
          }
        }
      });

      // Make sure the active card stays centered when resizing the screen.
      $(window).resize(self.resize);
      self.resize();
    };

    this.resize = function() {
      var parent_width = $card_wrapper.parent().outerWidth(),
        marginless_card_width = $cards.eq(0).outerWidth(),
        card_margin = card_width - marginless_card_width,
        padding = (
          parent_width - marginless_card_width
        ) / 2 - card_margin;
      $card_wrapper.css({
        paddingLeft: padding
      });
    };

    this.selectCard = function() {
      if (has_dragged) {
        return;
      }

      self.snapToCard($(this));
    };

    this.selectBullet = function() {
      self.snapToCard($cards.eq($(this).index()));
    };

    this.snapToCard = function($card) {
      $cards.add($navigation_bullets).removeClass("active");
      $current_card = $card;
      $current_card.addClass("active");
      $navigation_bullets.eq($current_card.index()).addClass("active");
      $("form button[name='delete-one-click']")
        .add("form button[name='use-one-click']")
        .val($current_card.data("card-id"));
      self.setOffset($card.index() * card_width * -1);
    };

    this.setOffset = function(offset) {
      if (offset < min_offset) {
        offset = min_offset;
      }
      else {
        if (offset > max_offset) {
          offset = max_offset;
        }
      }

      current_wrapper_offset = offset;
      $card_wrapper.css({
        left: current_wrapper_offset
      });
    };

    this.startDrag = function(event) {
      if (event.type == "mousedown" && event.button != 0) {
        return;
      }

      has_dragged = false;
      initial_wrapper_offset = current_wrapper_offset;
      initial_drag_offset = self.getOffsetFromEvent(event);
      current_drag_offset = initial_drag_offset;
      $card_wrapper.addClass("active");
      $(window)
        .off("mousemove touchmove mouseup touchend")
        .on("mousemove touchmove", self.drag)
        .on("mouseup touchend", self.stopDrag);
    };

    this.drag = function(event) {
      event.preventDefault();
      has_dragged = true;
      var event_offset = self.getOffsetFromEvent(event),
        new_offset =
          current_wrapper_offset +
          (
            event_offset - current_drag_offset
          );
      current_drag_offset = event_offset;
      self.setOffset(new_offset);
    };

    this.stopDrag = function() {
      $(window).off("mousemove touchmove mouseup touchend");
      $card_wrapper.removeClass("active");

      // Don't do anything if we didn't actually notice a drag.
      if (!has_dragged) {
        return;
      }

      var relative_offset = current_wrapper_offset - initial_wrapper_offset;
      if (relative_offset < -slide_threshold && $current_card.next().length) {
        self.snapToCard($current_card.next());
      }
      else {
        if (
          relative_offset > slide_threshold &&
          $current_card.prev().length
        ) {
          self.snapToCard($current_card.prev());
        }
        else {
          self.snapToCard($current_card);
        }
      }
    };

    this.getOffsetFromEvent = function(event) {
      if (event.type.substr(0, 5) == "touch" && typeof event.originalEvent !== "undefined") {
        if (typeof event.originalEvent.targetTouches !== "undefined") {
          return event.originalEvent.targetTouches[0].pageX;
        }

        if (typeof event.originalEvent.touches !== "undefined") {
          return event.originalEvent.touches[0].pageX;
        }
      }

      if (typeof event.pageX !== "undefined") {
        return event.pageX;
      }

      /*
       * If for some reason the browser events don't make sense, the user will have to fall back to the regular card
       * navigation.
       */
      return 0;
    };

    this.__construct();
  }

  function isNumeric(n) {
    return !isNaN(parseFloat(n)) && isFinite(n);
  }

  function validateIso7064Checksum(string) {
    string = string.toUpperCase().replace(/[^A-Z0-9]+/g, "");
    var input = "" + string.substr(4) + string.substr(0, 4);
    var output = 0;
    for (var i = 0; i < input.length; i++) {
      if (isNumeric(input[i])) {
        output += "" + input[i];
      }
      else {
        // Convert "A".."Z" to "10".."35"
        output +=
          "" +
          (
            input[i].charCodeAt(0) - 55
          );
      }
    }

    while (output.length > 10) {
      output =
        (
          output.substr(0, 10) % 97
        ) + output.substr(10);
    }

    return output % 97 === 1;
  }
});
