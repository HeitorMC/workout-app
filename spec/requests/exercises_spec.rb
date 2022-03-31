# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/exercises', type: :request do
  describe 'GET /index' do
    before do
      create(:exercise)
      user = create(:user, email: 'John_Doe@test.com', password: 'password')
      user.confirm
      sign_in(user)
    end

    it 'renders a successful response' do
      get exercises_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    before do
      user = create(:user, email: 'John_Doe@test.com', password: 'password')
      user.confirm
      sign_in(user)
    end

    let(:exercises) { create_list(:exercise, 5) }

    it 'renders a successful response' do
      get exercise_path(exercises.last)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    before do
      user = create(:user, email: 'John_Doe@test.com', password: 'password')
      user.confirm
      sign_in(user)
    end

    it 'renders a successful response' do
      get new_exercise_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    before do
      user = create(:user, email: 'John_Doe@test.com', password: 'password')
      user.confirm
      sign_in(user)
    end

    let(:exercise) { create_list(:exercise, 5) }

    it 'renders a successful response' do
      get edit_exercise_path(exercise.last)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    context 'when the parameters are valid' do
      before do
        user = create(:user, email: 'John_Doe@test.com', password: 'password')
        user.confirm
        sign_in(user)
      end

      let(:valid_attributes) { { exercise: { name: 'Squat', description: 'lorem', intensity: 9 } } }

      it 'creates a new Exercise' do
        expect { post exercises_path(valid_attributes) }.to change(Exercise, :count).by(1)
      end

      it 'redirects to the created exercise' do
        post exercises_path(valid_attributes)
        expect(response).to redirect_to(exercise_path(Exercise.last))
      end
    end

    context 'when the parameters are invalid' do
      before do
        user = create(:user, email: 'John_Doe@test.com', password: 'password')
        user.confirm
        sign_in(user)
      end

      let(:invalid_attributes) { { exercise: { name: '', description: '', intensity: 'x' } } }

      it 'does not create a new Exercise' do
        expect { post exercises_path(invalid_attributes) }.to change(Exercise, :count).by(0)
      end

      it 'renders unprocessable entity response' do
        post exercises_path(invalid_attributes)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'when the parameters are valid' do
      before do
        user = create(:user, email: 'John_Doe@test.com', password: 'password')
        user.confirm
        sign_in(user)
      end

      let(:valid_attributes) { { exercise: { name: 'Squat', description: 'lorem', intensity: 9 } } }
      let(:basic_exercise) { create(:exercise) }

      it 'updates the requested exercise' do
        patch exercise_path(basic_exercise.id, valid_attributes)
        expect(response).to have_http_status(:found)
      end

      it 'redirects to the exercise' do
        patch exercise_path(basic_exercise.id, valid_attributes)
        expect(response).to redirect_to(exercise_path(basic_exercise.id))
      end
    end

    context 'when the parameters are invalid' do
      before do
        user = create(:user, email: 'John_Doe@test.com', password: 'password')
        user.confirm
        sign_in(user)
      end

      let(:invalid_attributes) { { exercise: { name: '', description: '', intensity: 'x' } } }
      let(:basic_exercise) { create(:exercise) }

      it 'renders unprocessable entity response)' do
        patch exercise_path(basic_exercise.id, invalid_attributes)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    before do
      user = create(:user, email: 'John_Doe@test.com', password: 'password')
      user.confirm
      sign_in(user)
    end

    let!(:basic_exercise) { create(:exercise) }

    it 'destroys the requested exercise' do
      expect { delete exercise_path(basic_exercise.id), headers: }.to change(Exercise, :count).by(-1)
    end

    it 'redirects to the exercises list' do
      delete exercise_path(basic_exercise.id), headers: headers
      expect(response).to redirect_to(exercises_path)
    end
  end
end
