# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/exercises', type: :request do
  describe 'GET /index' do
    let(:user) { create(:user, email: 'John_Doe@test.com', password: 'password') }
    let!(:auth) { sign_in(user) }
    let!(:exercise) { create(:exercise) }

    before { get exercises_path }

    it 'renders a successful response' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    let(:user) { create(:user, email: 'John_Doe@test.com', password: 'password') }
    let!(:auth) { sign_in(user) }
    let!(:exercises) { create_list(:exercise, 5) }

    before { get exercise_path(exercises.last) }

    it 'renders a successful response' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    let(:user) { create(:user, email: 'John_Doe@test.com', password: 'password') }
    let!(:auth) { sign_in(user) }

    before { get new_exercise_path }

    it 'renders a successful response' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    let(:user) { create(:user, email: 'John_Doe@test.com', password: 'password') }
    let!(:auth) { sign_in(user) }
    let!(:exercise) { create_list(:exercise, 5) }

    before { get edit_exercise_path(exercise.last) }

    it 'renders a successful response' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    context 'when the parameters are valid' do
      let(:valid_attributes) { { exercise: { name: 'Squat', description: 'lorem', intensity: 9 } } }
      let(:user) { create(:user, email: 'John_Doe@test.com', password: 'password') }
      let!(:auth) { sign_in(user) }

      it 'creates a new Exercise' do
        expect { post exercises_path(valid_attributes) }.to change(Exercise, :count).by(1)
      end

      it 'redirects to the created exercise' do
        post exercises_path(valid_attributes)
        expect(response).to redirect_to(exercise_path(Exercise.last))
      end
    end

    context 'when the parameters are invalid' do
      let(:invalid_attributes) { { exercise: { name: '', description: '', intensity: 'x' } } }
      let(:user) { create(:user, email: 'John_Doe@test.com', password: 'password') }
      let!(:auth) { sign_in(user) }

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
      let(:user) { create(:user, email: 'John_Doe@test.com', password: 'password') }
      let!(:auth) { sign_in(user) }
      let(:valid_attributes) { { exercise: { name: 'Squat', description: 'lorem', intensity: 9 } } }
      let(:basic_exercise) { create(:exercise) }

      before { patch exercise_path(basic_exercise.id, valid_attributes) }

      it 'updates the requested exercise' do
        expect(response).to have_http_status(:found)
      end

      it 'redirects to the exercise' do
        expect(response).to redirect_to(exercise_path(basic_exercise.id))
      end
    end

    context 'when the parameters are invalid' do
      let(:invalid_attributes) { { exercise: { name: '', description: '', intensity: 'x' } } }
      let(:user) { create(:user, email: 'John_Doe@test.com', password: 'password') }
      let!(:auth) { sign_in(user) }
      let(:basic_exercise) { create(:exercise) }

      before { patch exercise_path(basic_exercise.id, invalid_attributes) }

      it 'renders unprocessable entity response)' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    let(:user) { create(:user, email: 'John_Doe@test.com', password: 'password') }
    let!(:auth) { sign_in(user) }
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
