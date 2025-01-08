# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :company
  validates :name, presence: true
  has_many :sub_tasks, dependent: :destroy
  has_rich_text :description
  broadcasts_to ->(task) { [task.company, 'tasks'] }, inserts_by: :prepend
end
