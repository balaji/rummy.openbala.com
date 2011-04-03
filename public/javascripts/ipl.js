var teamImages = new Array();
var indexImages = new Array();
var promoImages = new Array();

var loadTeamImages = function() {
  if (teamImages.length == 0) {
    var images = new Array();
    images.push("https://s3-ap-southeast-1.amazonaws.com/openbala/csk-over.png");
    images.push("https://s3-ap-southeast-1.amazonaws.com/openbala/dc-over.png");
    images.push("https://s3-ap-southeast-1.amazonaws.com/openbala/dd-over.png");
    images.push("https://s3-ap-southeast-1.amazonaws.com/openbala/kkr-over.png");
    images.push("https://s3-ap-southeast-1.amazonaws.com/openbala/ktk-over.png");
    images.push("https://s3-ap-southeast-1.amazonaws.com/openbala/kx-over.png");
    images.push("https://s3-ap-southeast-1.amazonaws.com/openbala/mi-over.png");
    images.push("https://s3-ap-southeast-1.amazonaws.com/openbala/rcb-over.png");
    images.push("https://s3-ap-southeast-1.amazonaws.com/openbala/rr-over.png");
    images.push("https://s3-ap-southeast-1.amazonaws.com/openbala/spw-over.png");

    for (var i = 0; i < images.length; i++) {
      var img = new Image();
      img.src = images[i];
      teamImages.push(img);
    }
  }
};

var loadIndexImages = function() {
  if (indexImages.length == 0) {
    var images = new Array();
    images.push("https://s3-ap-southeast-1.amazonaws.com/openbala/stadia-over.jpg");
    images.push("https://s3-ap-southeast-1.amazonaws.com/openbala/teams-over.jpg");
    images.push("https://s3-ap-southeast-1.amazonaws.com/openbala/schedule-over.jpg");
    images.push("https://s3-ap-southeast-1.amazonaws.com/openbala/gilli-over.jpg");
    images.push("https://s3-ap-southeast-1.amazonaws.com/openbala/rummyg-over.jpg");
    images.push("https://s3-ap-southeast-1.amazonaws.com/openbala/mangatha-over.jpg");

    for (i = 0; i < images.length; i++) {
      var img = new Image();
      img.src = images[i];
      indexImages.push(img);
    }
  }
};

var loadPromoImages = function() {
  if (promoImages.length == 0) {
    var images = new Array();
    images.push("https://s3-ap-southeast-1.amazonaws.com/openbala/icc-cwc-promo-over.png");
    images.push("https://s3-ap-southeast-1.amazonaws.com/openbala/ipl-promo-over.png");

    for (i = 0; i < images.length; i++) {
      var img = new Image();
      img.src = images[i];
      promoImages.push(img);
    }
  }
};

$(document).ready(function() {

  var imageSrc = function(element) {
    if (element.hasClass('jsTeam'))
      return teamImages[element.attr("name")].src;
    else if (element.hasClass('jsIndex'))
      return indexImages[element.attr("name")].src;
    else
      return promoImages[element.attr("name")].src;
  };

  var addOverImage = function(element) {
    document.images[element.attr("name")].src = imageSrc(element);
  };

  var removeOverImage = function(element) {
    var src = element.attr("src").replace("-over", "");
    element.attr("src", src);
    element.css("cursor", "pointer");
  };

  var clickImage = function(element) {
    window.location.href = element.attr("alt");
  };

  $(function() {
    $('.jsChoose')
        .click(function() {
      var selected = $(this).val();
      if ($(this).attr('checked')) {
        $('.iplTeam').each(function() {
          if (selected == $(this).text()) {
            $(this).addClass("ipl_select");
          }
        });
      } else {
        $('.iplTeam').each(function() {
          if (selected == $(this).text()) {
            $(this).removeClass("ipl_select");
          }
        });
      }
    });
  });

  $(function() {
    $("img.swap")
        .mousedown(function() {
      addOverImage($(this));
    })
        .mouseover(function() {
      removeOverImage($(this));
    })
        .click(function() {
      clickImage($(this));
    });
  });

  $(function() {
    $("img.hoverswap")
        .mouseover(function() {
      addOverImage($(this));
    })
        .mouseout(function() {
      removeOverImage($(this));
    })
        .click(function() {
      clickImage($(this));
    });
  });
});

