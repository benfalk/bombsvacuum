function pretty_time_string(num) {
    return ( num < 10 ? "0" : "" ) + num;
}

var boom = false;
var start = new Date;

setInterval(function () {
    var total_seconds = (new Date - start) / 1000;
    var hours = Math.floor(total_seconds / 3600);
    total_seconds = total_seconds % 3600;
    var minutes = Math.floor(total_seconds / 60);
    total_seconds = total_seconds % 60;
    var seconds = Math.floor(total_seconds);
    hours = pretty_time_string(hours);
    minutes = pretty_time_string(minutes);
    seconds = pretty_time_string(seconds);
    var currentTimeString = minutes + ":" + seconds;
    $('#game-timer').text(currentTimeString);
}, 1000);

// MARKER STUFF
var marker = 'uncovered';

// FIELDS AJAX STUFF
function reset() {
    $('.field').click(function () {
        $.ajax({
            type: "POST",
            url: '/fields/' + $(this).data('field_id') + '/locations/' + $(this).data('id') + '.js',
            data: {
                _method: $(this).data('method'),
                'action': $(this).data('action'),
                'controller': $(this).data('controller'),
                'location': {
                    'state': marker
                },
                'id': $(this).data('id'),
                'field_id': $(this).data('field_id')
            },
            dataType: 'script',
            success: function (msg) {
                console.log("Data Saved");
            }
        });
    }).contextmenu(function (e) {
            $.ajax({
                type: "POST",
                url: '/fields/' + $(this).data('field_id') + '/locations/' + $(this).data('id') + '.js',
                data: {
                    _method: $(this).data('method'),
                    'action': $(this).data('action'),
                    'controller': $(this).data('controller'),
                    'location': {
                        'state': 'flagged'
                    },
                    'id': $(this).data('id'),
                    'field_id': $(this).data('field_id')
                },
                dataType: 'script',
                success: function (msg) {
                    console.log("Data Saved");
                }
            });
            e.preventDefault();
            return false;
        });


}
$(function () {
    // MARKER STUFF
    $('#flag-button').click(function () {
        if (marker == 'uncovered') {
            $(".flag").addClass('icon-flag');
            $(".flag").removeClass('icon-flag-alt');
            marker = 'flagged';
        } else {
            $(".flag").addClass('icon-flag-alt');
            $(".flag").removeClass('icon-flag');
            marker = 'uncovered';
        }
    });
    // TIMMER TOGGLE
    $('#timmer-button').click(function () {
        $('.screen').fadeToggle();
    });

    reset();
});

$('#clickme').click(function() {
  $('#book').animate({
    opacity: 0.25,
    left: '+=50',
    height: 'toggle'
  }, 5000, function() {
    // Animation complete.
  });
});

// Fade In and Out
setInterval(function ()
{

    $('.fadeIO').animate(
    {
    opacity: 0.50
    }, 1500, function() {
        $(this).animate(
        {
        opacity: 1.0
        }, 1500);
    });


}, 3000);