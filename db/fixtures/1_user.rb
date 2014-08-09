user = User.new(
  :email => 'pulkit.ag02@gmail.com',
  :password => '12345678'
  # :name => "SuperAdmin",
)
user.skip_confirmation!
user.save!