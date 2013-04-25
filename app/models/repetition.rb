class Repetition < ActiveRecord::Base
  
  attr_accessible :planned_date, :actual_date
  
  belongs_to :flashcard
  
  after_update :set_next_repetition
  
  
  # TODO Эту функцию надо перестроить, чтобы return был в конце.
  # TODO Ещё здесь содержится та же логика, что и в repetition.rb, от этого нужно избавиться.
  def set_next_repetition
    if run
      if successful
        flashcard.consecutive_successful_repetitions += 1
        if flashcard.consecutive_successful_repetitions < 3
          next_planned_interval = rand((flashcard.last_planned_interval * 2)..(flashcard.last_planned_interval * 3))
        else
          return
        end
      else
        flashcard.consecutive_successful_repetitions = 0
        next_planned_interval = rand(1..3)
      end
      flashcard.save
      next_repetition_date = actual_date + next_planned_interval.days
      flashcard.repetitions.create :planned_date => next_repetition_date, :actual_date => next_repetition_date
    end
  end
  
end
