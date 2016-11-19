var io = require('socket.io').listen(5001),
    redis = require('redis').createClient(),
    clients = [];

redis.subscribe('task');

io.on('connection', function(socket) {
  redis.on('message', function(channel, message) {
    if (channel === 'task') {
      var message = JSON.parse(message);
      socket.emit(message.task, message.data);
    }
  });

  socket.on('client_response_connect', function(data){
    if (data.client) {
      clients.push({
        socket_id: socket.id,
        device_id: data.device_id
      });
    }
  });

  socket.on('ls_response_current_value', function(data) {
    var response_socket_ids = clients.filter(function(client){
      return client.device_id === data.device_id
    }).map(function(client) {
      return client.socket_id;
    });

    response_socket_ids.forEach(function(socket_id){
      io.sockets.connected[socket_id].emit('client_update_view', data);
    });
  });

  socket.on('disconnect', function () {
    clients = clients.filter(function(client){
      return client.socket_id !== socket.id
    });
  });
});
