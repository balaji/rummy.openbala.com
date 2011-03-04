document.observe("dom:loaded", function() {

    var hoverIn = function () {
      this.sector.stop();
      this.sector.scale(1.1, 1.1, this.cx, this.cy);
      if (this.label) {
      this.label[0].stop();
      this.label[0].scale(1.5);
      this.label[1].attr({"font-weight": 800});
      }
      }

    var hoverOut = function () {
      this.sector.animate({scale: [1, 1, this.cx, this.cy]}, 500, "bounce");
      if (this.label) {
      this.label[0].animate({scale: 1}, 500, "bounce");
      this.label[1].attr({"font-weight": 400});
      }
      }

    var paintPieChart = function(id, radius, values, descriptions) {
      $(id).innerHTML = "";
      var width = jQuery(id).css('width');
    var paper = Raphael(id, width, 600);
    var pie = paper.g.piechart(radius + 20, radius + 10, radius, values, {legend: descriptions, 
      legendpos: "south"});
    pie.hover(hoverIn, hoverOut);
    }

    $('country_stats_select').observe('change', (function(event) {
          if(event.target.value == "") {
          $('raphael_runs').innerHTML = "";
          $('raphael_points').innerHTML = "";
          $('raphael_wickets').innerHTML = "";
          return;
          }
          jQuery('#raphael_runs').html('<img src="images/ajax-loader.gif" alt="loading"/>');
          jQuery('#raphael_points').html('<img src="images/ajax-loader.gif" alt="loading"/>');
          jQuery('#raphael_wickets').html('<img src="images/ajax-loader.gif" alt="loading"/>');
          jQuery.ajax({ url: "/statistics/country_stats",
                        method: 'get',
                        data: {country_id: event.target.value},
                        dataType: "json",
                        success:function(response) {
                            var scores = new Array();
                            var s_names = new Array();
                            var p_names = new Array();
                            var w_names = new Array();
                            var points = new Array();
                            var wickets = new Array();
                            jQuery.each(response, function(x) {
                              var j = jQuery.parseJSON(response[x]);
                              scores.push(j.score);
                              points.push(j.points);
                              wickets.push(j.wickets);
                              s_names.push("%%.%% - " + j.name + " (" + j.score +" runs)");
                              p_names.push("%%.%% - " + j.name + " (" + j.points +" points)");
                              w_names.push("%%.%% - " + j.name + " (" + j.wickets +" Wickets)");
                            });
                            paintPieChart('raphael_runs', 120, scores, s_names);
                            paintPieChart('raphael_points', 120, points, p_names);
                            paintPieChart('raphael_wickets', 120, wickets, w_names);
                        },
                        failure:function(){
                        }
          });
    }));
});
