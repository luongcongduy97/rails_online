# frozen_string_literal: true

class SubTaskItem < ApplicationRecord
  belongs_to :sub_task
  validates :name, presence: true
  validates :priority_level, presence: true, numericality: { only_integer: true }

  def next_item
    sub_task.sub_task_items
            .where('priority_level >= ?', priority_level)
            .where.not(id:)
            .order(priority_level: :asc)
            .first
  end
end
