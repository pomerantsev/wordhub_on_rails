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

  validates :planned_date, presence: true
  validates :actual_date, presence: true,
                          timeliness: { on_or_after: lambda { |r| r.planned_date } }
  validates :flashcard_id, presence: true,
                           existence: true
  validates :run, inclusion: { in: [false] },
                  if: lambda { |r| r.actual_date.present? and r.actual_date > Date.today }

  belongs_to :flashcard

  before_update do
    # Don't let updating of already run repetitions.
    return false if run
    self.run = true unless successful.nil?
  end

  after_update { flashcard.set_next_repetition if run }

end
