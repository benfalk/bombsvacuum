function pretty_time_string(num)
{
    return ( num < 10 ? "0" : "" ) + num;
}

var boom = false;
var start = new Date;

setInterval(function()
{
    var total_seconds = (new Date - start) / 1000;
    var hours = Math.floor(total_seconds / 3600);
    total_seconds = total_seconds % 3600;
    var minutes = Math.floor(total_seconds / 60);
    total_seconds = total_seconds % 60;
    var seconds = Math.floor(total_seconds);
    hours = pretty_time_string(hours);
    minutes = pretty_time_string(minutes);
    seconds = pretty_time_string(seconds);
    var currentTimeString = minutes + ": " + seconds;
    $('#game-timer').text(currentTimeString);
}, 1000);

// MARKER STUFF
var marker = 'uncovered';

// FIELDS AJAX STUFF
function reset()
{
    $('.field').click(function()
    {
        $.ajax({
            type: "POST",
            url: '/fields/'+$(this).data('field_id')+'/locations/'+$(this).data('id')+'.js',
            data: {
                _method:$(this).data('method'),
                'action':$(this).data('action'),
                'controller':$(this).data('controller'),
                'location':{
                    'state':marker
                },
                'id':$(this).data('id'),
                'field_id':$(this).data('field_id')
            },
            dataType: 'script',
            success: function(msg)
            {
                console.log( "Data Saved" );
            }
        });
    }).contextmenu(function(e){
        $.ajax({
            type: "POST",
            url: '/fields/'+$(this).data('field_id')+'/locations/'+$(this).data('id')+'.js',
            data: {
                _method:$(this).data('method'),
                'action':$(this).data('action'),
                'controller':$(this).data('controller'),
                'location':{
                    'state':'flagged'
                },
                'id':$(this).data('id'),
                'field_id':$(this).data('field_id')
            },
            dataType: 'script',
            success: function(msg)
            {
                console.log( "Data Saved" );
            }
        });
        e.preventDefault();
        return false;
    });



}
$(function()
{
    // MARKER STUFF CONTINUED
    $('#flag').click(function()
    {
        if (marker == 'uncovered')
        {
            $(this).addClass('flag-filled');
            marker = 'flagged';
        }else{
            $(this).removeClass('flag-filled');
            marker = 'uncovered';
        }
    });
    reset();
});
