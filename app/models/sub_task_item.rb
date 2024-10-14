# frozen_string_literal: true

class SubTaskItem < ApplicationRecord
  belongs_to :sub_task

  validates :name, presence: true
  validates :priority_level, presence: true, numericality: { only_integer: true }
end
