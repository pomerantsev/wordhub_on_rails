include FlashcardsHelper

# learned_on field is used for stats.
# No need in executing complex SQL queries anymore.
class AddLearnedOnToFlashcards < ActiveRecord::Migration
  def change
    add_column :flashcards, :learned_on, :date
    migrate_learned_dates
  end
end
