$(document).ready(function() {
  var latlng = new google.maps.LatLng(23.1256, 78.3106);
  var myOptions = { zoom: 5,
                    center: latlng,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
  };

  var matches = function(id, googleInfo) {
    googleInfo.setContent('<img src="images/ajax-loader.gif" alt="loading"/>');
    $.ajax({
      url: "/ipl/stadium",
      method: "get",
      data: {city: id},
      dataType: "json",
      success: function(response) {
        var html = "<div style='height: 160px;width:350px;'><div class='scorecard graublau'><b>" + id + "</b></div>";
        $.each(response, function(item) {
          var j = $.parseJSON(response[item]);
          html += "<div class='map_disp'><b>" + j.date + "</b> - " + j.team_one + "&nbsp;v.&nbsp;" + j.team_two + "</div>"; 
        });
        html += "</div>"
        googleInfo.setContent(html);
      },
      failure: function(response) {
      }
    });
  }

  var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
  var iplPlaces = [['Hyderabad', 17.3753, 78.4744],
                    ['Chennai', 13.0901, 80.2701 ],
                    ['Mumbai', 18.9647, 72.8258 ],
                    ['Delhi', 28.61, 77.23],
                    ['Indore', 22.7, 75.9],
                    ['Dharamsala', 32.17, 76.26],
                    ['Kochi', 9.97, 76.33],
                    ['Bangalore', 12.97, 77.63],
                    ['Mohali', 30.78, 76.69],
                    ['Navi-Mumbai', 19.03, 73.01],
                    ['Jaipur', 27, 75.83],
                    ['Kolkata', 22.5697, 88.3697 ]];

  var info = new google.maps.InfoWindow();
  for(var i = 0; i < iplPlaces.length; i ++) {
    var marker = new google.maps.Marker({position: new google.maps.LatLng(iplPlaces[i][1], iplPlaces[i][2]), map: map, title: iplPlaces[i][0]});
    google.maps.event.addListener(marker, 'click', function() {matches(this.getTitle(), info); info.open(map, this);});
  }
});
