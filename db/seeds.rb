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
  name: 'SGardern',
  address: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit'
)

device = farm.create_device(
  ip: '192.168.0.114'
)

camera = farm.create_camera(CameraCreating.build(
  ip: 'http://je4452.myfoscam.org',
  port: '133',
  username: 'guest',
  password: 'vutran_513'
))

start_time = Time.parse('2016-11-01 00:00:00')
4320.times do |time|
  temperature   = rand(20...40)
  humidity      = rand(0..100)
  soil_moisture = rand(0..100)
  light         = rand(2000...3000)

  Value.create(
    light: light,
    humidity: humidity,
    temperature: temperature,
    soil_moisture: soil_moisture,
    created_at: start_time + time*10.minutes,
    device: device,
  )
end
