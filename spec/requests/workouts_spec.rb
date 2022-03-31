# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/workouts', type: :request do
  describe 'GET /index' do
    before do
      create(:workout)
      user = create(:user, email: 'John_Doe@test.com', password: 'password')
      sign_in(user)
    end

    it 'renders a successful response' do
      get workouts_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    before do
      user = create(:user, email: 'John_Doe@test.com', password: 'password')
      sign_in(user)
    end

    let(:workouts) { create_list(:workout, 5) }

    it 'renders a successful response' do
      get workout_path(workouts.last)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    before do
      user = create(:user, email: 'John_Doe@test.com', password: 'password')
      sign_in(user)
    end

    it 'renders a successful response' do
      get new_workout_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    before do
      user = create(:user, email: 'John_Doe@test.com', password: 'password')
      sign_in(user)
    end

    let(:workouts) { create_list(:workout, 5) }

    it 'renders a successful response' do
      get edit_workout_path(workouts.last)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    context 'when the parameters are valid' do
      before do
        user = create(:user, email: 'John_Doe@test.com', password: 'password')
        sign_in(user)
      end

      let(:valid_attributes) { { workout: { name: 'Euro Training' } } }

      it 'creates a new Workout' do
        expect { post workouts_path(valid_attributes) }.to change(Workout, :count).by(1)
      end

      it 'redirects to the created workout' do
        post workouts_path(valid_attributes)
        expect(response).to redirect_to(workout_path(Workout.last))
      end
    end

    context 'when the parameters are invalid' do
      before do
        user = create(:user, email: 'John_Doe@test.com', password: 'password')
        sign_in(user)
      end

      let(:invalid_attributes) { { workout: { name: '' } } }

      it 'does not create a new Workout' do
        expect { post workouts_path(invalid_attributes) }.to change(Workout, :count).by(0)
      end

      it 'renders unprocessable entity response' do
        post workouts_path(invalid_attributes)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'when the parameters are valid' do
      before do
        user = create(:user, email: 'John_Doe@test.com', password: 'password')
        sign_in(user)
      end

      let(:valid_attributes) { { workout: { name: 'Euro Training' } } }
      let(:workout) { create(:workout) }

      it 'updates the requested workout' do
        patch workout_path(workout.id, valid_attributes)
        expect(response).to have_http_status(:found)
      end

      it 'redirects to the workout' do
        patch workout_path(workout.id, valid_attributes)
        expect(response).to redirect_to(workout_path(workout.id))
      end
    end

    context 'when the parameters are invalid' do
      before do
        user = create(:user, email: 'John_Doe@test.com', password: 'password')
        sign_in(user)
      end

      let(:invalid_attributes) { { workout: { name: '' } } }
      let(:workout) { create(:workout) }

      it 'renders unprocessable entity response' do
        patch workout_path(workout.id, invalid_attributes)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    before do
      user = create(:user, email: 'John_Doe@test.com', password: 'password')
      sign_in(user)
    end

    let(:exercise) { create_list(:exercise, 2) }
    let!(:workout) { create(:workout, exercise_ids: [exercise.first.id, exercise.last.id]) }

    it 'destroys the requested workout' do
      expect { delete workout_path(workout.id) }.to change(Workout, :count).by(-1)
    end

    it 'redirects to the workouts list' do
      delete workout_path(workout.id)
      expect(response).to redirect_to(workouts_path)
    end
  end
end
