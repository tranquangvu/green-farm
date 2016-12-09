var io = require('socket.io').listen(5001),
    redis = require('redis').createClient(),
    clients = [], ls_socket_id;

redis.subscribe('task');

io.on('connection', function(socket) {
  redis.on('message', function(channel, message) {
    if (channel === 'task') {
      var message = JSON.parse(message);
      socket.emit(message.task, message.data);
    }
  });

  socket.on('ls_response_connect', function(data) {
    if (data.ls) {
      ls_socket_id = socket.id
    }
  });

  socket.on('client_response_connect', function(data){
    if (data.client) {
      clients.push({
        socket_id: socket.id,
        device_id: data.device_id
      });
    }

    io.sockets.connected[ls_socket_id].emit('get_current_value', {
      device: {id: data.device_id, ip: data.device_ip}
    });
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

  socket.on('client_change_led', function(data) {
    if (data.status) {
      io.sockets.connected[ls_socket_id].emit('turn_on_led', {
        device: {id: data.device_id, ip: data.device_ip}
      });
    }
    else {
      io.sockets.connected[ls_socket_id].emit('turn_off_led', {
        device: {id: data.device_id, ip: data.device_ip}
      });
    }
  });

  socket.on('client_change_servo', function(data) {
    if (data.status) {
      io.sockets.connected[ls_socket_id].emit('turn_on_servo', {
        device: {id: data.device_id, ip: data.device_ip}
      });
    }
    else {
      io.sockets.connected[ls_socket_id].emit('turn_off_servo', {
        device: {id: data.device_id, ip: data.device_ip}
      });
    }
  });

  socket.on('ls_response_device_status', function(data) {
    var response_socket_ids = clients.filter(function(client){
      return client.device_id === data.device_id
    }).map(function(client) {
      return client.socket_id;
    });

    response_socket_ids.forEach(function(socket_id) {
      io.sockets.connected[socket_id].emit('client_update_view', data);
    });
  });

  socket.on('disconnect', function () {
    clients = clients.filter(function(client){
      return client.socket_id !== socket.id
    });
  });
});
