module UsersHelper
  def total_stats(stats)
    [{ name: t(".total_flashcards"),
       value: stats[:total_flashcards] },
     { name: t(".learned"),
       value: stats[:learned_flashcards] },
     { name: t(".total_repetitions_planned"),
       value: stats[:total_planned_repetitions] },
     { name: t(".nearest_repetitions"),
       value: "#{stats[:planned_repetitions_for_nearest_date]} (#{stats[:nearest_date]})" },
     { name: t(".planned_until"),
       value: stats[:last_date_with_planned_repetitions] }
    ]
  end

  def stats_for_period(stats)
    [{ name: t(".created"),
       value: stats[:created] },
     { name: t(".learned"),
       value: stats[:learned] },
     { name: t(".total_repetitions"),
       value: stats[:repetitions_run] },
     { name: t(".successful_repetitions"),
       value: "#{stats[:successful_repetitions]} (#{stats[:successful_repetitions_percentage]}%)" }
     ]
  end
end
