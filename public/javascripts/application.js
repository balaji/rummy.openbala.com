document.observe("dom:loaded", function() {
    var messageToDrag = "";
    var mappedSlots = new Hash();
    var prevMatchId = "";
    var unsetAny = function(index) {
        var key;
        mappedSlots.each(function(entry) {
            if (entry.value == index) {
                key = entry.key;
            }
        });

        if (key) {
            mappedSlots.unset(key);
        }
    }

    $$('.block_t').each(function(item) {
        item.observe('click', function(ev) {
            var id = ev.target.id;
            var data_id = jQuery(".data").attr("id")
            var panel = jQuery('.panel');
            var panel2 = jQuery('.panel2');
            var panel_width = jQuery('.panel').css('left');

            if (parseInt(panel.css('left'), 0) == 0 || prevMatchId != id) {
                prevMatchId = id;
                jQuery('.data').html('<img src="images/ajax-loader.gif" alt="loading"/>');
                jQuery.ajax({
                    url: "/profile/user_game_data",
                    method: 'get',
                    data: {match_id: id},
                    dataType: "json",
                    success:function(response) {
                        var html = "";
                        if (response.length == 0) {
                            html = "<div class='scorecard'>No Data</div>";
                        } else {
                            jQuery.each(response, function(x) {
                                var j = jQuery.parseJSON(response[x]);
                                html += "<div id='user_" + x + "' class='block_t2 scorecard' align='left' onclick='loadLevelTwo(\"" + j.player_order + "\", this, " + id + ")'>&nbsp;"+ (x + 1) +".&nbsp;"
                                        + j.name + " - &nbsp;&nbsp;" + j.points + "</div>"
                            });
                        }
                        jQuery('.data').html(html);
                        jQuery('.data').attr("id", id);
                    },
                    failure:function() {
                        alert('Ugh. tough luck. call 9500069498 immediately.');
                    }
                });
            }

            if (data_id == id) {
                panel.animate({left: parseInt(panel.css('left'), 0) == 0 ? + panel.outerWidth() : 0});
                panel2.animate({left: parseInt(panel2.css('left'), 0) == 0 ? + panel2.outerWidth() : 0});
            } else {
                if (panel_width == '301px') {
                    if (parseInt(panel2.css('left'), 0) > 301) panel2.animate({left: 301});
                } else {
                    panel.animate({left: parseInt(panel.css('left'), 0) == 0 ? + panel.outerWidth() : 0});
                    panel2.animate({left: parseInt(panel2.css('left'), 0) == 0 ? + panel2.outerWidth() : 0});
                }
            }
            return false;
        });
    });

    $('save_players').observe('click', (function(event) {
        if (mappedSlots.keys().size() < 5) {
            alert('choose all 5');
            return;
        }

        mappedSlots.toJSON();

        new Ajax.Request("/game/save", {
            method: 'get',
            parameters: {preferences: mappedSlots.toJSON(), match_id: $('match_id').value},
            onSuccess:function() {
                alert('saved! Check back once the game is over for your points.');
            },
            onFailure:function() {
                alert('Ugh. tough luck. call 9500069498 immediately.');
            }
        });
    }));

    $$('.draggable').each(function(item, index) {
        new Draggable(item.id, {
            revert: function(element) {
                if (messageToDrag == "don't") {
                    messageToDrag = "";
                    return true;
                }

                if (messageToDrag == "just added") {
                    messageToDrag = "";
                    return 'failure';
                }
                unsetAny(element.id);
                return 'failure';
            }
        });
    });

    $$('.droppable').each(function(item, index) {
        Droppables.add(item.id, {
            accept: 'draggable',
            hoverclass: 'hover',
            onDrop: function(dragged, dropped, event) {
                unsetAny(dragged.id);
                if (mappedSlots.get(dropped.id)) {
                    messageToDrag = "don't";
                    return;
                }
                mappedSlots.set(dropped.id, dragged.id);
                messageToDrag = "just added";
                var position = $(dropped).positionedOffset();
                jQuery($(dragged.id)).offset({left: position[0] + 1, top: position[1] + 3});
                $(dropped.id).highlight();
            }
        });
    });
});


function loadLevelTwo(order, element, match_id) {
    var id = element.id;
    var data_id = jQuery(".data2").attr("id");
    var panel = jQuery('.panel2');
    var panel_width = jQuery('.panel2').css('left');

    jQuery('.data2').html('<img src="images/ajax-loader.gif" alt="loading"/>');
    jQuery.ajax({
        url: "/profile/player_profile",
        method: 'get',
        data: {match_id: match_id, order: order},
        dataType: "json",
        success:function(response) {
            var html = "<strong class='scorecard'>User Choice</strong><br/><br/>";
            if (response.length == 0) {
                html = "<div class='scorecard'>No Data</div>";
            } else {
                jQuery.each(response, function(x) {
                    var j = jQuery.parseJSON(response[x]);
                    html += "<div class='grid_3 scorecard' align='left'>&nbsp;&nbsp;" + j.player + " - " + j.points + "</div>" +
                            "<div class='clear'>&nbsp;</div>";
                });
                html += "<br/><strong class='scorecard'>Best (theoretical) Choice</strong><br/><br/>";

                jQuery.each(response, function(x) {
                    var j = jQuery.parseJSON(response[x]);
                    html += "<div class='grid_3 scorecard' align='left'>&nbsp;&nbsp;" + j.top_player + " - " + j.top_points + "</div>" +
                            "<div class='clear'>&nbsp;</div>"
                });
            }
            jQuery('.data2').html(html);
            jQuery('.data2').attr("id", id);
        },
        failure:function() {
            alert('Ugh. tough luck. call 9500069498 immediately.');
        }
    });

    if (data_id == id) {
        panel.animate({left: parseInt(panel.css('left'), 0) == 301 ? + panel.outerWidth() + 300 : 301});
    } else {
        if (panel_width == '601px') {
        } else {
            panel.animate({left: parseInt(panel.css('left'), 0) == 301 ? + panel.outerWidth() + 300 : 301});
        }
    }
    return false;
}