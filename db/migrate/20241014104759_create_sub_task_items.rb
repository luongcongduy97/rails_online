# frozen_string_literal: true

class CreateSubTaskItems < ActiveRecord::Migration[7.1]
  def change
    create_table :sub_task_items do |t|
      t.references :sub_task, null: false, foreign_key: true
      t.string :name
      t.integer :priority_level

      t.timestamps
    end
  end
end
