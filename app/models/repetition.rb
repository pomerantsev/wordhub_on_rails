# == Schema Information
#
# Table name: repetitions
#
#  id           :integer          not null, primary key
#  flashcard_id :integer
#  planned_date :date
#  actual_date  :date
#  run          :boolean          default(FALSE)
#  successful   :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Repetition < ActiveRecord::Base
  
  attr_accessible :planned_date, :actual_date
  
  belongs_to :flashcard
  
  before_update { self.run = true unless successful.nil? }

  after_update { flashcard.set_next_repetition if run }
  
end
