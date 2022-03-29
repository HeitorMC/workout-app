# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExerciseWorkout, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:exercise) }
    it { is_expected.to belong_to(:workout) }
  end
end
