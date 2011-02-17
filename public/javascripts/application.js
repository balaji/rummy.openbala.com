document.observe("dom:loaded", function() {
    var messageToDrag = "";
    var mappedSlots = new Hash();
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
                alert('saved!');
            },
            onFailure:function() {
                alert('boo ya!');
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