# frozen_string_literal: true

class CreateJoinTableExerciseWorkout < ActiveRecord::Migration[7.0]
  def change
    create_table :exercises_workouts, id: false do |t|
      t.belongs_to :exercise, foreign_key: true
      t.belongs_to :workout, foreign_key: true
    end
  end
end
