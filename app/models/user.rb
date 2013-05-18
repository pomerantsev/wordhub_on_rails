# coding: UTF-8

class User < ActiveRecord::Base
  
  attr_accessible :name, :email, :password, :daily_limit



  has_many :flashcards, dependent: :destroy do
    
    # Карточки пользователя, созданные в определённую дату (пока - по времени сервера).
    def created_on(date)
      beginning_of_day = date.to_time   # Так можно вычислить полночь в часовом поясе сервера.
      where(created_at: beginning_of_day..(beginning_of_day + 1.day))
    end
    

    def grouped_by_date
      flashcards_by_date = {}
      order("id ASC").each do |flashcard|
        date = flashcard.created_at.localtime.to_date
        flashcards_by_date[date] ||= [] # Если nil?, то становится пустым массивом.
        flashcards_by_date[date] << flashcard
      end
      return flashcards_by_date
    end

    def deleted
      Flashcard.unscoped { where deleted: true }
    end

    def deleted_before(date)
      deleted.where("updated_at < ?", date.to_time)
    end
    
  end



  has_many :repetitions, through: :flashcards do
    
    def planned
      where(run: false)
    end
    

    def run
      where(run: true)
    end
    

    # Два одинаковых метода с разными названиями - чтобы не коверкать язык.
    # planned.for (запланированные на дату), но run.on (выполненные в определённую прошедшую дату).
    def for(date)
      where(actual_date: date)
    end
    

    def on(date)
      where(actual_date: date)
    end
    

    # Доля выученных сегодня карточек, от запланированных. Нужна, чтобы показывать прогресс-бар.
    def progress_today
      today = Date.today
      run.on(today).size.to_f / on(today).size
    end
    

    # Используется для дебага.
    def planned_count_by_date
      planned.group(:actual_date).count
    end
    

    # Если на прошедшие даты у пользователя остались не выполненные повторы, все повторы переносятся.
    # С самой ранней даты, на которую остались повторы, всё переносится на сегодня, остальные - на то же количество дней вперёд.
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
  
  validates :name, length: { maximum: 25 }
  validates :email, presence: true,
                    length: { maximum: 100 },
                    uniqueness: { case_sensitive: false },
                    format: EMAIL_REGEX
  validates :password, length: {within: 6..25},
                       on: :create
  validates :daily_limit, inclusion: { :in => 1..100 }
  


  before_save { email.downcase! }
  before_save :create_hashed_password
  after_save :clear_password
  
  

  def password_match?(password = "")
    if salt.present?
      hashed_password == User.hash_with_salt(password, salt)
    else # Для учётных записей, перекочевавших из старого PHP-шного сайта
      hashed_password == User.hash_without_salt(password)
    end
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
  

  def self.hash_without_salt(password = "")
    Digest::SHA1.hexdigest(password)
  end



  private
  
  def create_hashed_password
    unless password.blank?
      self.salt = User.make_salt(email) if salt.blank?
      self.hashed_password = User.hash_with_salt(password, salt)
    end
  end
  
  
  def clear_password
    self.password = nil
  end
   
end
