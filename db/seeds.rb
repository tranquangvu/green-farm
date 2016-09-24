puts '================= CREATE USER ================='
User.delete_all
ActiveRecord::Base.connection.execute("ALTER SEQUENCE users_id_seq RESTART WITH 1")
User.create(email: 'ben.tran@futureworkz.com', username: 'ben', password: '123123')

puts '================= CREATE CAMERA ================='
Camera.delete_all
ActiveRecord::Base.connection.execute("ALTER SEQUENCE cameras_id_seq RESTART WITH 1")
CameraCreating.create(
  ip: 'http://je4452.myfoscam.org',
  port: '133',
  username: 'user',
  password: 'user123'
)
