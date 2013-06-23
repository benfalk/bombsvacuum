function pretty_time_string(num) {
    return ( num < 10 ? "0" : "" ) + num;
  }

var start = new Date;    

setInterval(function() {
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

  $('.timer').text(currentTimeString);
}, 1000);