# frozen_string_literal: true

class Workout < ApplicationRecord
  validates :name, presence: true
  has_and_belongs_to_many :exercises
end
