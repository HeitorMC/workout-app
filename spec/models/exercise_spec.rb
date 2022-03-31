# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Exercise, type: :model do
  describe 'validations' do
    subject { build(:exercise) }

    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:description) }

    it { is_expected.to validate_presence_of(:intensity) }
    it { is_expected.to validate_inclusion_of(:intensity).in_range(0..10) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:exercise_workouts) }
    it { is_expected.to have_many(:workouts).through(:exercise_workouts) }
  end
end
