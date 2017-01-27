class User < ActiveRecord::Base
  
  #a gem that will encrypt the password into hash and store it in the db
  has_secure_password
  
  has_many :articles
  before_save { self.email = email.downcase }
  validates :username, presence: true, 
            uniqueness: {case_sensitive: false  }, 
            length: { in: 5..25 }
            
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
            
  validates :email, presence: true, length: { maximum: 100 },
            uniqueness: {case_sensitive: false  },
            format: { with: VALID_EMAIL_REGEX } 
  
end