node(:success) { true }
child(@user) { extends 'users/user' }
child(@repetitions, object_root: false) { extends 'repetitions/repetition' }
node(:stats) do
  {
    totalStats: {
      totalFlashcards: @total_stats[:total_flashcards],
      learnedFlashcards: @total_stats[:learned_flashcards],
      totalPlannedRepetitions: @total_stats[:total_planned_repetitions],
      nearestDate: @total_stats[:nearest_date],
      plannedRepetitionsForNearestDate: @total_stats[:planned_repetitions_for_nearest_date],
      lastDateWithPlannedRepetitions: @total_stats[:last_date_with_planned_repetitions]
    },
    statsForMonth: {
      created: @stats_for_month[:created],
      learned: @stats_for_month[:learned],
      repetitionsRun: @stats_for_month[:repetitions_run],
      successfulRepetitions: @stats_for_month[:successful_repetitions],
      successfulRepetitionsPercentage: @stats_for_month[:successful_repetitions_percentage]
    },
    statsForToday: {
      created: @stats_for_today[:created],
      learned: @stats_for_today[:learned],
      repetitionsRun: @stats_for_today[:repetitions_run],
      successfulRepetitions: @stats_for_today[:successful_repetitions],
      successfulRepetitionsPercentage: @stats_for_today[:successful_repetitions_percentage]
    }
  }
end
