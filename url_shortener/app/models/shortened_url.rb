require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :long_url, :short_url, :submitter_id
  validates :long_url, presence: true
  validates :short_url, uniqueness: true, presence: true
  validates :submitter_id, presence: true

  belongs_to(
  :submitter,
  :class_name => "User",
  :foreign_key => :submitter_id,
  :primary_key => :id
  )


  def self.random_code(long_url)
    random_code = SecureRandom.urlsafe_base64[0..15]
    # until ShortenedUrl.find_by_sql(["SELECT * FROM shortened_urls s WHERE s.short_url = ?", random_code]).empty?
    until !ShortenedUrl.find_by_short_url(random_code)
      random_code = SecureRandom.urlsafe_base64[0..15]
    end

    random_code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    short_url = ShortenedUrl.random_code(long_url)
    ShortenedUrl.create!({ :long_url => long_url, :short_url => short_url, :submitter_id => user.id })
  end

end
