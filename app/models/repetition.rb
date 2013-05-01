class Repetition < ActiveRecord::Base
  
  attr_accessible :planned_date, :actual_date
  
  belongs_to :flashcard
  
  after_update :set_next
  
  
  def set_next
    if run
      flashcard.set_next_repetition
    end
  end
  
end
