# coding: UTF-8

class Flashcard < ActiveRecord::Base
  
  attr_accessible :front_text, :back_text
  
  belongs_to :user
  has_many :repetitions, :dependent => :destroy
  
  validates :front_text, :presence => true
  validates :back_text, :presence => true
  
  after_create :set_first_repetition
  
  def set_first_repetition
    first_repetition_date = rand(1..3).days.from_now.to_date
    self.consecutive_successful_repetitions = 0
    self.repetitions.create :planned_date => first_repetition_date, :actual_date => first_repetition_date
    
  end
  
  def last_planned_interval
    if repetitions.size == 0
      0
    elsif repetitions.size == 1
      repetitions.first.planned_date - repetitions.first.created_at.to_date
    else
      last_two_repetitions = repetitions.order("actual_date ASC").offset(repetitions.size - 2)
      last_two_repetitions.last.planned_date - last_two_repetitions.first.planned_date
    end
  end
  
  def learned?
    return repetitions.where(:run => false).empty?
  end
  
end
