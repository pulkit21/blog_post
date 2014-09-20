class Post < ActiveRecord::Base

  validates_presence_of :title, :body
  belongs_to :user
  has_many :comments
  acts_as_votable
  scope :sorted, lambda {order('published_at')}
  scope :published, lambda {where('published_at IS NOT NULL')}
  # scope :published, lambda {where("published_at IS NOT NULL AND published_at <= ?", Time.now.strftime('%a, %d %b %Y %H:%M:%S UTC +00:00'))}
  # scope :unpublished, lambda {where('published_at <= ?',Time.now.strftime('%a, %d %b %Y %H:%M:%S UTC +00:00'))}

  after_create :update_post_path, on: :create
  # before_save :update_post_path
  #Publish the blogpost
  def publish!
    if self.published_nil?
      self.update_attributes(published_at: Time.now)
    elsif published?
      errors.add(:base, "The post has already been published") and return false
    end  
  end

  #Unpublish the blogpost
  def unpublish!
    if self.published?
      self.update_attributes(published_at: nil)
    else self.published_nil?
      errors.add(:base, "The post has not been published yet") and return false
    end
  end

  # Check if the post is current user post
  def users_post(user)
    self.user.id == user.id if !user.nil?
  end

  #If Post published time present 
  def published?
    self.published_at.present?
  end

  #If publish time is nill
  def published_nil?
    self.published_at.nil?
  end

  #For parameterize
  def to_param
    "#{id}-#{title.parameterize}"
  end

  #Update the field post_path in database
  def update_post_path
    self.post_path = to_param
    self.save!
  end

  #Publish it at time
  def published_time
    self.published_at <= Time.now.strftime('%a, %d %b %Y %H:%M:%S UTC +00:00')
  end

  #Date format
  def set_date
    self.published_at.strftime("%b %d, %Y")
  end

  # Date format in list page
  def post_created_at
    self.created_at.strftime("%b %d, %Y %I:%M %p")
  end

  # Date format in list page
  def post_published_at
    self.published_at.strftime("%b %d, %Y %I:%M %p")
  end

  # Time format
  def set_time
    self.published_at.strftime("%I:%M %p")
  end

  def published_true?
    if self.published?
      true
    else
      false
    end
  end
end
