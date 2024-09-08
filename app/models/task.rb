# frozen_string_literal: true

class Task < ApplicationRecord
  validates :name, presence: true

  broadcasts_to ->(_task) { 'tasks' }, inserts_by: :prepend
end
