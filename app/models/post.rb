class Post < ActiveRecord::Base

  validates_presence_of :title, :body
  belongs_to :user

  scope :sorted, lambda {order('published_at')}
  scope :published, lambda {where('published_at IS NOT NULL')}
  # scope :unpublished, lambda {where('published_at IS NULL')}

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

end
