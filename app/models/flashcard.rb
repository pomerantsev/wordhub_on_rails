# == Schema Information
#
# Table name: flashcards
#
#  id                                 :integer          not null, primary key
#  user_id                            :integer
#  front_text                         :text
#  back_text                          :text
#  consecutive_successful_repetitions :integer          default(0)
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#  deleted                            :boolean          default(FALSE)
#  learned_on                         :date
#


class Flashcard < ActiveRecord::Base

  default_scope { where(deleted: false) }

  validates :front_text, presence: true
  validates :back_text, presence: true
  validates :user_id, presence: true,
                      existence: true
  validates :deleted, inclusion: { in: [true, false] }
  validates :learned_on, timeliness: { on_or_before: lambda { Date.today } },
                         allow_nil: true

  belongs_to :user

  has_many :repetitions, dependent: :destroy do

    # Planned interval between two last repetitions of this flashcard.
    # It is used for planning the next repetition date.
    # planned_date is set once, at the time when the repetition is created.
    # actual_date can change if the user hasn't repeated
    # the flashcard on the planned date.
    # So the interval cannot grow indefinitely since it is based
    # only on planned intervals which cannot be greater than a month.
    def last_planned_interval
      if size == 0
        0
      elsif size == 1
        first.planned_date - first.created_at.localtime.to_date
      else
        last_two_repetitions = order("id ASC").offset(size - 2)
        # abs is getting called so that specs do not
        # throw an error when a negative value is encountered
        (last_two_repetitions.last.planned_date - last_two_repetitions.first.actual_date).abs
      end
    end

  end

  after_create :set_first_repetition

  # The first interval is one to three days long.
  def set_first_repetition
    first_repetition_date = Date.today + rand(1..3).days
    repetitions.create planned_date: first_repetition_date, actual_date: first_repetition_date
  end

  # If the repetition is successful, the next interval will be
  # 2 to 3 times longer than the last planned.
  # Otherwise, the interval is calculated the same as for
  # the first repetition.
  # TODO: it would be wiser to send the repetition's id
  # since last could be something else here.
  def set_next_repetition
    if repetitions.order("id ASC").last.successful
      self.consecutive_successful_repetitions += 1
      next_planned_interval = rand((repetitions.last_planned_interval * 2)..(repetitions.last_planned_interval * 3))
    else
      self.consecutive_successful_repetitions = 0
      next_planned_interval = rand(1..3)
    end
    save
    if consecutive_successful_repetitions < WhRails::Application.config.max_consecutive_successful_repetitions
      # repetitions.last.actual_date is always the current date.
      next_repetition_date = repetitions.order("id ASC").last.actual_date + next_planned_interval.days
      repetitions.create planned_date: next_repetition_date, actual_date: next_repetition_date
    else
      self.learned_on = Date.today
      save
    end
  end

  # If the flashcard has been successfully repeated
  # three times, it is considered learned.
  def learned?
    consecutive_successful_repetitions >= WhRails::Application.config.max_consecutive_successful_repetitions
  end

  # TODO: remove this duplication (same used in user.rb)
  # This is here only for migration's purposes.
  scope :learned, -> { where("consecutive_successful_repetitions >= ?", WhRails::Application.config.max_consecutive_successful_repetitions) }

  def created_today?
    created_at >= Date.today.to_time
  end

end
