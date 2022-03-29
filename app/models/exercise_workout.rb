# frozen_string_literal: true

class ExerciseWorkout < ApplicationRecord
  belongs_to :exercise
  belongs_to :workout
end
