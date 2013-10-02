class User < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :email
  validates :email, uniqueness: true, presence: true

  has_many(
  :submitted_urls,
  :class_name => "ShortenedUrl",
  :foreign_key => :submitter_id,
  :primary_key => :id
  )

end
