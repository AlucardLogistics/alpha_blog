class Category < ActiveRecord::Base
  
  #setting up the many to many relation of category table with article_categories table
  has_many :article_categories
  has_many :articles, through: :article_categories
  
  validates :name, presence: true, length: { minimum: 4, maximum: 25  }
  validates_uniqueness_of :name
  
end