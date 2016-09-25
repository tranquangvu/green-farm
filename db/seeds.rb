puts '================= DROP DATA ================='
User.delete_all
ActiveRecord::Base.connection.execute("ALTER SEQUENCE users_id_seq RESTART WITH 1")

Farm.delete_all
ActiveRecord::Base.connection.execute("ALTER SEQUENCE farms_id_seq RESTART WITH 1")

Camera.delete_all
ActiveRecord::Base.connection.execute("ALTER SEQUENCE cameras_id_seq RESTART WITH 1")

puts '================= SEED ================='
user = User.create(
  email: 'ben.tran@futureworkz.com',
  username: 'ben',
  password: '123123'
)
farm = user.farms.create(
  address: '666/64/5 Ly Thuong Kiet, TPHCM',
  section_index: 0
)
farm.cameras << CameraCreating.create(
  ip: 'http://je4452.myfoscam.org',
  port: '133',
  username: 'guest',
  password: 'vutran_513'
)

