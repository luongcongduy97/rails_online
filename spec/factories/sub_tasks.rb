# frozen_string_literal: true

FactoryBot.define do
  factory :sub_task do
    task
    due_date { '2024-09-21' }
  end
end
