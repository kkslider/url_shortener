class Visit < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :user_id, :shortened_id
  validates :user_id, presence: true
  validates :shortened_id, presence: true

  belongs_to(
  :user,
  :class_name => "User",
  :foreign_key => :user_id,
  :primary_key => :id
  )

  belongs_to(
  :shortened_url,
  :class_name => "ShortenedUrl",
  :foreign_key => :shortened_id,
  :primary_key => :id
  )



  def self.record_visit!(user, shortened_url)
    Visit.create!({ :user_id => user.id, :shortened_id => shortened_url.id })
  end

end
