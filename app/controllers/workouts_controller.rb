# frozen_string_literal: true

class WorkoutsController < ApplicationController
  before_action :set_workout, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @workouts = Workout.all
  end

  def show; end

  def new
    @workout = Workout.new
  end

  def edit; end

  def create
    @workout = Workout.new(workout_params)

    if @workout.save
      redirect_to @workout, notice: 'Workout was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @workout.update(workout_params)
      redirect_to @workout, notice: 'Workout was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @workout.destroy
    redirect_to workouts_url, notice: 'Workout was successfully destroyed.'
  end

  private

  def set_workout
    @workout = Workout.find(params[:id])
  end

  def workout_params
    params.require(:workout).permit(:name, exercise_ids: [])
  end
end
