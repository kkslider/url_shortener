class User < ActiveRecord::Base
  # attr_accessible :title, :body
  validates :email, uniqueness: true, presence: true


end
