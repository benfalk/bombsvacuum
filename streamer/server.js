var express = require('express');
var app = express();
var redis = require('redis');

/**
 * Ultra simple pub/sub setup
 */
app.get('/field/:id',function(req,res){

   req.socket.setTimeout(Infinity);
   
   var client = redis.createClient();
   req.on("close", function() {
     console.log("Closing connection ["+req.param('id')+']');
     client.unsubscribe();
     client.quit();
   });

   res.writeHead(200, {
     'Content-Type': 'text/event-stream',
     'Cache-Control': 'no-cache',
     'Connection': 'keep-alive',
     'Access-Control-Allow-Origin': '*'
   });

  res.write('\n');

  console.log('New Connection Established [Field '+req.param('id')+']');

  client.on('message',function(channel,msg){
    res.write('data:'+msg+'\n\n');
  });
  
  client.subscribe('field:'+req.param('id'));

});


app.listen(8080);
console.log('Listening on 8080...');
