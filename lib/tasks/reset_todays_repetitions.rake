desc "Reset today's repetitions (start from scratch)"
task reset_todays_repetitions: :environment do
  current_date = Time.now.localtime.to_date
  repetitions = Repetition.where(run: true, actual_date: current_date)
  flashcards = repetitions.map(&:flashcard)
  flashcards.each do |f|
    repetitions_to_destroy = f.repetitions.where(run: false)
    puts "Deleting upcoming repetitions (#{repetitions_to_destroy.count}) for flashcard #{f.id}"
    repetitions_to_destroy.destroy_all
  end
  repetitions.each { |r| r.update_attributes(run: false, successful: nil) }
end
