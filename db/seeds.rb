puts '================= CREATE USER ================='

User.delete_all
ActiveRecord::Base.connection.execute(
  "ALTER SEQUENCE users_id_seq RESTART WITH 1"
)
User.create(email: 'ben.tran@futureworkz.com', username: 'ben', password: '123123')
