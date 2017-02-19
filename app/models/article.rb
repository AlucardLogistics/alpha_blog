class Article < ActiveRecord::Base
  
  #setting up the one to many relation of articles table with user table
  belongs_to :user
  #setting up the many to many relation of articles table with article_categories table
  has_many :article_categories
  has_many :categories, through: :article_categories
  
  validates :title, presence: true, length: { minimum: 5, maximum: 25 }
  validates :description, presence: true, length: { minimum: 15, maximum: 300 }
  validates :user_id, presence: true
end