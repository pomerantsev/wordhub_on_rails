class Repetition < ActiveRecord::Base
  
  attr_accessible :planned_date, :actual_date
  
  belongs_to :flashcard
  
  before_update { self.run = true unless successful.nil? }

  after_update { flashcard.set_next_repetition if run }
  
end
