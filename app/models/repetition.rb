class Repetition < ActiveRecord::Base
  
  attr_accessible :planned_date, :actual_date
  
  belongs_to :flashcard
  
  before_update :mark_as_run

  after_update :set_next
  

  def mark_as_run
  	self.run = true
  end
  
  def set_next
    flashcard.set_next_repetition
  end
  
end
