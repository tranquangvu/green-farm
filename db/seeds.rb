puts '--> Drop old data'
User.delete_all
Farm.delete_all
Device.delete_all
Camera.delete_all
Value.delete_all

puts '--> Seed'
user = User.create(email: 't@e.com', username: 'ben', password: '123123')
admin = Admin.create(email: 'admin@sgardern.com', password: '123123')

farm = user.farms.create(
  name: 'SGardern',
  address: 'HCMC University of Technology',
  max_limit_temperature: 40,
  min_limit_temperature: 20,
  max_limit_humidity: 70,
  min_limit_humidity: 30,
  max_limit_light: 300,
  min_limit_light: 3,
  max_limit_soil_moisture: 70,
  min_limit_soil_moisture: 30,
  auto_control: true
)

device = farm.create_device(ip: '192.168.0.113')

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
    device: device
  )
end

start_time = Time.parse('2016-12-01 00:00:00')
4464.times do |time|
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
    device: device
  )
end

start_time = Time.parse('2017-01-01 00:00:00')
492.times do |time|
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
    device: device
  )
end
