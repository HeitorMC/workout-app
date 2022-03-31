# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Workout, type: :model do
  describe 'validations' do
    subject { build(:workout) }

    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:exercise_workouts) }
    it { is_expected.to have_many(:exercises).through(:exercise_workouts) }
  end
end
