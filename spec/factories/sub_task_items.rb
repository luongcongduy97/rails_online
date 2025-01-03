# frozen_string_literal: true

FactoryBot.define do
  factory :sub_task_item do
    sub_task { nil }
    name { 'MyString' }
    priority_level { 1 }
  end
end
