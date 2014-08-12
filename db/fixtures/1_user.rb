user = User.new(
  :email => 'pulkit.ag02@gmail.com',
  :password => '12345678',
  :username => "lucifer21"
)
user.skip_confirmation!
user.save!