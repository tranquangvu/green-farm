puts '--> Drop old data'
User.delete_all
Farm.delete_all
Device.delete_all
Camera.delete_all
Value.delete_all

puts '--> Seed'
user = User.create(
  email: 't@e.com',
  username: 'ben',
  password: '123123'
)

farm = user.farms.create(
  name: 'SGardern',
  address: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit'
)

device = farm.create_device(
  ip: '192.168.0.117'
)

camera = farm.create_camera(CameraCreating.build(
  ip: 'http://192.168.0.220',
  port: '80',
  username: 'admin',
  password: 'admin123456'
))

start_time = Time.parse('2016-11-01 00:00:00')
4320.times do |time|
  temperature   = rand(23..28)
  humidity      = rand(40..60)
  soil_moisture = rand(50..60)
  light         = rand(400...600)

  Value.create(
    light: light,
    humidity: humidity,
    temperature: temperature,
    soil_moisture: soil_moisture,
    created_at: start_time + time*10.minutes,
    device: device,
  )
end
