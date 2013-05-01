# coding: UTF-8

class User < ActiveRecord::Base
  
  attr_accessible :name, :email, :password, :daily_limit



  has_many :flashcards, :dependent => :destroy do
    
    def created_on(date)
      where(:created_at => date.beginning_of_day..date.end_of_day)
    end
    
  end



  has_many :repetitions, :through => :flashcards do
    
    def planned
      where(:run => false)
    end
    
    def run
      where(:run => true)
    end
    
    def for(date)
      where(:actual_date => date)
    end
    
    def on(date)
      where(:actual_date => date)
    end
    
    def planned_count_by_date
      planned.group(:actual_date).count
    end
    
    def adjust_dates(date)
      first_date = planned.minimum(:actual_date)
      if first_date && first_date < date
        gap = date - first_date
        planned.each do |repetition|
          repetition.increment!(:actual_date, gap)
        end
      end 
    end
    
  end
  
  attr_accessor :password
  
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  
  validates :name, :length => {:maximum => 25}
  validates :email, :presence => true,
                    :length => {:maximum => 100},
                    :uniqueness => true,
                    :format => EMAIL_REGEX
  validates :password, :length => {:within => 6..25}
  
  before_save :create_hashed_password
  after_save :clear_password
  
  

  def password_match?(password = "")
    hashed_password == User.hash_with_salt(password, salt)
  end
  
  def self.authenticate(email, password)
    user = User.find_by_email(email)
    if user && user.password_match?(password)
      return user
    else
      return false
    end
  end
  
  def self.make_salt(email = "")
    Digest::SHA1.hexdigest("Use #{email} with #{Time.now} to make salt")
  end
  
  def self.hash_with_salt(password = "", salt = "")
    Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
  end
    
  private
  
  def create_hashed_password
    # Whenever :password has a value hashing is needed
    unless password.blank?
      # always use "self" when assigning values
      self.salt = User.make_salt(email) if salt.blank?
      self.hashed_password = User.hash_with_salt(password, salt)
    end
  end
  
  def clear_password
    # for security and b/c hashing is not needed
    self.password = nil
  end
   
end
