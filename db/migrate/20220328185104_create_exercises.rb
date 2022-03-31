# frozen_string_literal: true

class CreateExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :exercises do |t|
      t.text :name, null: false
      t.text :description, null: false
      t.integer :intensity, null: false

      t.timestamps
    end
  end
end
