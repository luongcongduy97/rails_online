# spec/system/authentication_spec.rb
require 'rails_helper'

RSpec.describe 'User Authentication', type: :system do
  let!(:company1) { create(:company, name: 'Existing Company 1') }
  let!(:company2) { create(:company, name: 'Existing Company 2') }
  let!(:user) { create(:user, email: 'user@example.com', password: 'password123', company: company1) }

  describe 'Sign Up' do
    it 'allows a user to sign up with an existing company' do
      visit new_user_registration_path

      fill_in 'Email', with: 'newuser@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'

      select 'Existing Company 1', from: 'company_selection'

      click_button 'Sign up'

      expect(page).to have_content('Welcome! You have signed up successfully.')
      expect(User.last.company.name).to eq('Existing Company 1')
    end

    it 'allows a user to sign up and create a new company' do
      visit new_user_registration_path

      fill_in 'Email', with: 'newuser2@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'

      select 'Create New Company', from: 'company_selection'
      fill_in 'New Company Name', with: 'New Company Name'

      click_button 'Sign up'

      expect(page).to have_content('Welcome! You have signed up successfully.')
      expect(User.last.company.name).to eq('New Company Name')
    end

    xit 'displays errors when required fields are missing' do
      visit new_user_registration_path

      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      fill_in 'Password confirmation', with: ''

      click_button 'Sign up'

      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")
    end
  end

  describe 'Login' do
    it 'allows a user to log in with valid credentials' do
      visit new_user_session_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password123'

      click_button 'Log in'

      expect(page).to have_content('Signed in successfully.')
      expect(page).to have_content(user.email)
    end

    it 'shows error with invalid credentials' do
      visit new_user_session_path

      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'wrongpassword'

      click_button 'Log in'

      expect(page).to have_content('Invalid Email or password.')
    end

    it 'allows the user to log out' do
      login_as(user, scope: :user)
      visit root_path

      click_button 'Sign out'

      expect(page).to have_content('Signed out successfully.')
    end
  end
end
