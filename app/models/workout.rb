# frozen_string_literal: true

class Workout < ApplicationRecord
  validates :name, presence: true

  has_many :exercise_workouts
  has_many :exercises, through: :exercise_workouts
end
