class ShortenedUrl < ActiveRecord::Base
  # attr_accessible :title, :body
  validates :long_url, presence: true
  validates :shortened_url, uniqueness: true, presence: true
  validates :submitter_id, presence: true
end
