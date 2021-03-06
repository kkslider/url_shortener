require 'securerandom'
require 'visit.rb'

class ShortenedUrl < ActiveRecord::Base
  attr_accessible :long_url, :short_url, :submitter_id
  validates :long_url, presence: true
  validates :short_url, presence: true, :uniqueness => true
  validates :submitter_id, presence: true

  belongs_to(
  :submitter,
  :class_name => "User",
  :foreign_key => :submitter_id,
  :primary_key => :id
  )

  has_many(
  :visits,
  :class_name => "Visit",
  :foreign_key => :shortened_id,
  :primary_key => :id
  )

  has_many :visitors, :through => :visits, :source => :user, :uniq => true

  def self.random_code(long_url)
    random_code = SecureRandom.urlsafe_base64[0..15]
    until !ShortenedUrl.find_by_short_url(random_code)
      random_code = SecureRandom.urlsafe_base64[0..15]
    end

    random_code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    short_url = ShortenedUrl.random_code(long_url)
    ShortenedUrl.create!({ :long_url => long_url, :short_url => short_url, :submitter_id => user.id })
  end

  def num_clicks
    visits.length
  end

  def num_uniques
    visits.count('user_id', :distinct => true)
  end

  def num_recent_uniques
    visits.where(:created_at => (3.hours.ago)..Time.now).count('user_id', :distinct => true)
  end
end
