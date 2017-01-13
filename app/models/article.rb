class Article < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 5, maximum: 25 }
  validates :description, presence: true, length: { minimum: 15, maximum: 300 }
end