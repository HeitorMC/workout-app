# frozen_string_literal: true

class Exercise < ApplicationRecord
  validates :description, :name, presence: true
  validates :intensity, presence: true, inclusion: { in: 0..10 }

  has_and_belongs_to_many :workouts
end
