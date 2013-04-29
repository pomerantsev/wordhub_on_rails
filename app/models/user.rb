# coding: UTF-8

class User < ActiveRecord::Base
  
  attr_accessible :name, :email, :password, :daily_limit
  
  has_many :flashcards
  
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

  def flashcard_count(date = nil)
    if !date
      self.flashcards.size
    else
      if (date.class != Date)
        date = date.to_date
      end
      self.flashcards.where("created_at > ? AND created_at < ?", date.beginning_of_day, date.end_of_day).size
    end
  end
  
  def repetitions_run_today(date = nil)
    if date.nil?
      date = Date.today
    end
    Repetition.where("flashcards.user_id = ?", self.id).joins(:flashcard).where(:actual_date => date, :run => true)
  end
  
  def total_repetitions_for_today_count(date = nil)
    if date.nil?
      date = Date.today
    end
    repetitions_run_today(date).size + planned_repetitions_for_date(date).size
  end
  
  # Это для статистики
  # Здесь нужно убрать повторяющийся кусок запроса.
  def planned_repetitions_count_by_date
    if !planned_repetitions_by_date.nil?
      return_value = {}
      planned_repetitions_by_date.each do |date, repetitions|
        return_value[date] = repetitions.size
      end
      return return_value
    else
      return nil
    end
  end
  
  def planned_repetitions_by_date
    all_planned_repetitions = Repetition.where("flashcards.user_id = ?", self.id).joins(:flashcard).where(:run => false).order("actual_date ASC")
    repetition_with_greatest_date = all_planned_repetitions.last
    if !repetition_with_greatest_date.nil?
      final_date = repetition_with_greatest_date.actual_date
      # Это добавлено пока на всякий случай, чтобы не выскакивало ошибок, когда Date.today больше, чем final_date
      first_date = all_planned_repetitions.first.actual_date
      return_value = {}
      for date in first_date..final_date
        return_value[date] = planned_repetitions_for_date(date)
      end
      return return_value
    else
      return nil
    end
  end
  
  def planned_repetitions_for_date(date)
    # Repetition.where("flashcards.user_id = ?", self.id).joins(:flashcard).where(:run => false, :actual_date => date)
    # Такой формат (вместо того, что вверху) - чтобы можно было здать :readonly => false - это чтобы массив, возвращаемый по джоину, не был ридонли. Иначе поменять даты для записей, полученных таким образом, нельзя
    Repetition.find :all, :joins => [:flashcard], :conditions => {:run => false, :actual_date => date}, :readonly => false
  end
  
  def adjust_repetition_dates(date = nil)
    if date.nil?
      date = Date.today
    end
    first_date_with_planned_repetitions = planned_repetitions_by_date.to_a[0][0]
    if first_date_with_planned_repetitions < date
      gap = date - first_date_with_planned_repetitions
      # Массив создаётся, потому что я толком не знаю, как эффективно работать с итераторами.
      # Reverse - это потому что я не всем записям сразу инкрементирую значение, а пишу конкретное значение для каждой. Позже можно прочитать про active record querying в guides.rubyonrails.org.
      all_dates_reverse = planned_repetitions_by_date.to_a.reverse.map do |repetitions|
        repetitions[0]
      end
      all_dates_reverse.each do |date|
        repetitions = planned_repetitions_for_date(date)
        if !repetitions.nil?
          repetitions.each do |repetition|
            repetition.update_attributes(:actual_date => (date + gap))
          end
        end
      end
    end
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
