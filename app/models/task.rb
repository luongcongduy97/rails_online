# frozen_string_literal: true

class Task < ApplicationRecord
  validates :name, presence: true

  after_create_commit -> { broadcast_prepend_to 'tasks' }
  after_update_commit -> { broadcast_replace_to 'tasks' }
end
