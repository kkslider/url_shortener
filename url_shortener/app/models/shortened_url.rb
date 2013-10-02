require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  # attr_accessible :title, :body
  validates :long_url, presence: true
  validates :shortened_url, uniqueness: true, presence: true
  validates :submitter_id, presence: true

  belongs_to(
  :submitter,
  :class_name => "User",
  :foreign_key => :submitter_id,
  :primary_key => :id
  )


  def self.random_code(long_url)
    random_code = SecureRandom.urlsafe_base64[0..15]
    until !ShortenedUrl.find_by_sql ["SELECT * FROM shortened_urls s WHERE s.shortened_url = ?", random_code].empty?
      random_code = SecureRandom.urlsafe_base64[0..15]
    end

    random_code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    shortened_url = ShortenedUrl.random_code(long_url)
    ShortenedUrl.create!({ :long_url => long_url, :shortened_url => shortened_url, :submitter_id => user.id })
  end



end
