#User one
user = User.new(
  :email => 'pulkit.ag02@gmail.com',
  :password => '12345678',
  :username => "pulkit21"
)
user.skip_confirmation!
user.save!
#User two
user = User.new(
  :email => 'lucifer21@gmail.com',
  :password => '12345678',
  :username => "lucifer21"
)
user.skip_confirmation!
user.save!