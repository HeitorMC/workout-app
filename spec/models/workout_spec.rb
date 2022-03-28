# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Workout, type: :model do
  describe 'Validations' do
    subject { build(:workout) }

    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'Associations' do
    it { is_expected.to have_and_belong_to_many(:exercises) }
  end
end
