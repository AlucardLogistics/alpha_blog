class User < ActiveRecord::Base
  
  #a gem that will encrypt the password into hash and store it in the db
  has_secure_password
  
  #a gem that will handle pictures for the profile pics
  has_attached_file :photo, styles: { medium: "400x400>", thumb: "100x100>" }, 
                            #default_url: 'images/missingProf.png'
                            default_url: ->(attachment) { ActionController::Base.helpers.asset_path('missingProf.png') }
                            validates_attachment_content_type :photo, 
                            content_type: /\Aimage\/.*\z/
  
  #if a user gets deleted it will delete all its articles destroy dependency
  has_many :articles, dependent: :destroy
  before_save { self.email = email.downcase }
  validates :username, presence: true, 
            uniqueness: {case_sensitive: false  }, 
            length: { in: 5..25 }
            
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
            
  validates :email, presence: true, length: { maximum: 100 },
            uniqueness: {case_sensitive: false  },
            format: { with: VALID_EMAIL_REGEX } 
  
end