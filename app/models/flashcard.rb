# coding: UTF-8

class Flashcard < ActiveRecord::Base
  
  attr_accessible :front_text, :back_text
  
  belongs_to :user
  has_many :repetitions
  
  validates :front_text, :presence => true
  validates :back_text, :presence => true
  
  after_create :set_first_repetition
  
  def set_first_repetition
    first_repetition_date = rand(1..3).days.from_now.to_date
    repetitions.create :planned_date => first_repetition_date, :actual_date => first_repetition_date
  end
  
end
