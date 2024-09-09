# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'validations' do
    it 'is valid with a name' do
      company = build(:company)
      expect(company).to be_valid
    end

    it 'is invalid without a name' do
      company = build(:company, name: nil)
      expect(company).not_to be_valid
      expect(company.errors[:name]).to include("can't be blank")
    end
  end
end
