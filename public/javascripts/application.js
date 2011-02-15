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
                jQuery($(dragged.id)).offset({left: position[0] + 3, top: position[1] + 3});
                $(dropped.id).highlight();
            }
        });
    });
});