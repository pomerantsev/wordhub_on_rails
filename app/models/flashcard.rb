# coding: UTF-8

class Flashcard < ActiveRecord::Base
  
  attr_accessible :front_text, :back_text
  
  belongs_to :user
  has_many :repetitions, :dependent => :destroy do
    
    def last_planned_interval
      if size == 0
        0
      elsif size == 1
        first.planned_date - first.created_at.to_date
      else
        last_two_repetitions = offset(size - 2)
        last_two_repetitions.last.planned_date - last_two_repetitions.first.actual_date
      end
    end
  
  end
  
  
  
  validates :front_text, :presence => true
  validates :back_text, :presence => true
  
  after_create :set_first_repetition
  
  
  
  def set_first_repetition
    first_repetition_date = Date.today + rand(1..3).days
    self.consecutive_successful_repetitions = 0
    repetitions.create :planned_date => first_repetition_date, :actual_date => first_repetition_date
  end
  
  def set_next_repetition
    if repetitions.last.successful
      self.consecutive_successful_repetitions += 1
      next_planned_interval = rand((repetitions.last_planned_interval * 2)..(repetitions.last_planned_interval * 3))
    else
      self.consecutive_successful_repetitions = 0
      next_planned_interval = rand(1..3)
    end
    save
    if consecutive_successful_repetitions < 3
      next_repetition_date = repetitions.last.actual_date + next_planned_interval.days
      repetitions.create :planned_date => next_repetition_date, :actual_date => next_repetition_date
    end
  end
  
  def learned?
    consecutive_successful_repetitions >= 3
  end
  
end
