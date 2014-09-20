class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:confirmable, :lockable, :timeoutable
  has_many :posts
  has_many :comments
  acts_as_voter
  validates_presence_of :username, :email, :password
  validates_uniqueness_of :username

  #For Gravatar image
  def avatar_user_url
    gravatar_id = Digest::MD5.hexdigest(self.email.downcase)
    "https://secure.gravatar.com/avatar/#{gravatar_id}"
  end


end
