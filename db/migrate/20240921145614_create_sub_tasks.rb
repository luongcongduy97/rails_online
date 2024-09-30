# frozen_string_literal: true

class CreateSubTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :sub_tasks do |t|
      t.references :task, null: false, foreign_key: true
      t.date :due_date, null: false

      t.timestamps
    end

    add_index :sub_tasks, %i[due_date task_id], unique: true
  end
end
