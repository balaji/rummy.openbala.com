  var teamImages = new Array();
  var indexImages = new Array();

  var loadTeamImages = function() {
    if (teamImages.length == 0) {
      var images = new Array();
      images.push("/images/csk-over.png");
      images.push("/images/dc-over.png");
      images.push("/images/dd-over.png");
      images.push("/images/kkr-over.png");
      images.push("/images/ktk-over.png");
      images.push("/images/kx-over.png");
      images.push("/images/mi-over.png");
      images.push("/images/rcb-over.png");
      images.push("/images/rr-over.png");
      images.push("/images/spw-over.png");

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
      images.push("/images/stadia-over.png");
      images.push("/images/teams-over.png");
      images.push("/images/schedule-over.png");
      images.push("/images/gilli-over.png");
      images.push("/images/rummyg-over.png");
      images.push("/images/mangatha-over.png");

      for (i = 0; i < images.length; i++) {
        var img = new Image();
        img.src = images[i];
        indexImages.push(img);
      }
    }
  };

$(document).ready(function() {

  var imageSrc = function(array, element) {
    return array[element.attr("name")].src;
  };

  var addOverImage = function(element) {
    document.images[element.attr("name")].src = (element.hasClass('jsTeam')) ? imageSrc(teamImages, element) : imageSrc(indexImages, element);
  };

  var removeOverImage = function(element) {
    var src = element.attr("src").replace("-over", "");
    element.attr("src", src);
    element.css("cursor", "pointer");
  };

  var clickImage = function(element) {
    window.location.href = element.attr("alt");
  };

  $(function(){
    $('.jsChoose')
    .click(function() {
      var selected = $(this).val();
      if($(this).attr('checked')) {
        $('.iplTeam').each(function() {
          if(selected ==$(this).text()) {
            $(this).addClass("ipl_select");
          }
        });
      } else {
        $('.iplTeam').each(function() {
          if(selected ==$(this).text()) {
            $(this).removeClass("ipl_select");
          }
        });
      }
    });
  });

  $(function() {
    $("img.swap")
    .mousedown(function() { addOverImage($(this)); })
    .mouseover(function() { removeOverImage($(this)); })
    .click(function(){ clickImage($(this)); });
  });

  $(function(){
    $("img.hoverswap")
    .mouseover(function() { addOverImage($(this)); })
    .mouseout(function() { removeOverImage($(this)); })
    .click(function() { clickImage($(this)); });
  });
});

