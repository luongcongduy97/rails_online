# frozen_string_literal: true

class Task < ApplicationRecord
  validates :name, presence: true

  after_create_commit -> { broadcast_prepend_to 'tasks', partial: 'tasks/task', locals: { quote: self } }
end
