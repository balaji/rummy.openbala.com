$(document).ready(function() {
  var addOverImage = function(element) {
    var src = element.attr("src").match(/[^\.]+/) + "-over.png";
    element.attr("src", src);
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

