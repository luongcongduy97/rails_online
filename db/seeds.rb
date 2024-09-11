# frozen_string_literal: true

require 'faker'

# Clear existing data to avoid duplication
Task.destroy_all
User.destroy_all
Company.destroy_all

5.times do
  company = Company.create!(
    name: Faker::Company.name
  )

  3.times do
    User.create!(
      email: Faker::Internet.email,
      password: 'password123',
      company:
    )

    5.times do
      Task.create!(
        name: Faker::Lorem.sentence(word_count: 3),
        description: Faker::Lorem.paragraph(sentence_count: 2),
        company:
      )
    end
  end
end
