# frozen_string_literal: true

# spec/factories/tasks.rb
FactoryBot.define do
  factory :task do
    name { 'MyString' }
    description { 'MyText' }
  end
end
