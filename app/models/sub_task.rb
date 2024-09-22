# frozen_string_literal: true

class SubTask < ApplicationRecord
  belongs_to :task

  validates :due_date, presence: true, uniqueness: { scope: :task_id, message: 'already exists for this task' }

  default_scope { order(due_date: :asc) }
end
