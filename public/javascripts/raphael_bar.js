document.observe("dom:loaded", function() {
    
    var paintBarChart = function(id, data, labels, desc) {
      $(id).innerHTML = "";
      var r = Raphael(id),
      fin = function () {
        this.flag = r.g.popup(this.bar.x, this.bar.y, this.bar.value + desc || "0").insertBefore(this);
      },
      fout = function () {
        this.flag.animate({opacity: 0}, 300, function () {this.remove();});
      };

      r.g.txtattr.font = "12px 'Fontin Sans', Fontin-Sans, sans-serif";
      var newLabels = new Array();
      jQuery.each(labels, function(index) {
        var texts = labels[index].split(" ");
        if(texts.length == 1) texts = labels[index].split("-");
        if(texts.length == 3) texts = [texts[0], texts[1] + " " + texts[2]];
        newLabels.push(texts.join("\n"));
      });
      r.g.barchart(30, 30, 900, 360, data).hover(fin, fout).label(newLabels, true);
    };

    jQuery('#raphael_top_runs').html('<img src="images/ajax-loader.gif" alt="loading"/>');
    jQuery('#raphael_top_wickets').html('<img src="images/ajax-loader.gif" alt="loading"/>');
    jQuery('#raphael_top_points').html('<img src="images/ajax-loader.gif" alt="loading"/>');
    jQuery.ajax({ url: "/toppers/toppers",
                  method: 'get',
                  dataType: "json",
                  success: function(response) {
                    var r_names = new Array();
                    var w_names = new Array();
                    var p_names = new Array();
                    var runs = new Array();
                    var wickets = new Array();
                    var points = new Array();
                    jQuery.each(response.top_runs, function(x) {
                      r_names.push(response.top_runs[x].name);
                      runs.push(response.top_runs[x].runs)
                    });
                    jQuery.each(response.top_wickets, function(x) {
                      w_names.push(response.top_wickets[x].name);
                      wickets.push(response.top_wickets[x].wickets)
                    });
                    jQuery.each(response.top_points, function(x) {
                      p_names.push(response.top_points[x].name);
                      points.push(response.top_points[x].points)
                    });
                    paintBarChart('raphael_top_runs', runs, r_names, " Runs");
                    paintBarChart('raphael_top_wickets', wickets, w_names, " Wickets");
                    paintBarChart('raphael_top_points', points, p_names, " Rummy points");
                  },
                  failure:function(){
                  }
    });
});
