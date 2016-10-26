puts '--> Drop old data'
User.delete_all
Farm.delete_all
Camera.delete_all

puts '--> Seed'
user = User.create(
  email: 'ben.tran@futureworkz.com',
  username: 'ben',
  password: '123123'
)

farm = user.farms.create(
  name: 'My first farm',
  address: '666/64/5 Ly Thuong Kiet, TPHCM'
)

farm.create_device(
  ip: '192.168.0.114'
)

farm.create_camera(CameraCreating.build(
  ip: 'http://je4452.myfoscam.org',
  port: '133',
  username: 'guest',
  password: 'vutran_513'
))
