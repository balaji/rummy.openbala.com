document.observe("dom:loaded", function() {
    var r = Raphael("raphael_top_runs"),
    fin = function () {
      this.flag = r.g.popup(this.bar.x, this.bar.y, this.bar.value + " runs" || "0").insertBefore(this);
    },
    fout = function () {
      this.flag.animate({opacity: 0}, 300, function () {this.remove();});
    };

    r.g.txtattr.font = "9px 'Fontin Sans', Fontin-Sans, sans-serif";

//    jQuery('#raphael_top_runs').html('<img src="images/ajax-loader.gif" alt="loading"/>');
    jQuery.ajax({ url: "/toppers/runs",
                  method: 'get',
                  dataType: "json",
                  success: function(response) {
                    var names = new Array();
                    var runs = new Array();
                    jQuery.each(response, function(x) {
                      names.push(response[x]["name"])               
                      runs.push(response[x]["runs"]);
                    });
                    r.g.barchart(30, 30, 900, 420, runs).hover(fin, fout).label(names, true, true);
                  },
                  failure:function(){
                  }
    });

});
