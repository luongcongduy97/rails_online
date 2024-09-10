# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :company
  validates :name, presence: true

  broadcasts_to ->(_task) { 'tasks' }, inserts_by: :prepend
end
