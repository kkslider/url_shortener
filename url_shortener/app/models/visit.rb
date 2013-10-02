class Visit < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :user_id, :shortened_id
  validates :user_id, presence: true
  validates :shortened_id, uniqueness: true, presence: true



end
