var io = require('socket.io').listen(5001),
    redis = require('redis').createClient(),
    web_clients = [];

redis.subscribe('task');

io.on('connection', function(socket) {
  redis.on('message', function(channel, message) {
    if (channel === 'task') {
      var message = JSON.parse(message);
      socket.emit(message.task, message.data);
    }
  });

  socket.on('response_connect', function(data){
    if (data.web_client) {
      web_clients.push({
        socket_id: socket.id,
        device_id: data.device_id
      });
    }
  });

  socket.on('response_current_value', function(data) {
    var response_socket_ids = web_clients.filter(function(client){
      return client.device_id === data.device_id
    }).map(function(client) {
      return client.socket_id;
    });

    response_socket_ids.forEach(function(socket_id){
      io.sockets.connected[socket_id].emit('render_value_view', data);
    });
  });

  socket.on('disconnect', function () {
    web_clients = web_clients.filter(function(client){
      return client.socket_id !== socket.id
    });
  });
});
