# frozen_string_literal: true

# spec/system/tasks_spec.rb

require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  describe 'task page' do
    let!(:company1) { create(:company) }
    let!(:company2) { create(:company) }
    let!(:user1) { create(:user, company: company1) }
    let!(:user2) { create(:user, company: company2) }
    let!(:task1) { create(:task, name: 'Test Task 1', description: 'Task description 1', company: company1) }
    let!(:task2) { create(:task, name: 'Test Task 2', description: 'Task description 2', company: company1) }
    let!(:task3) do
      create(:task, name: 'Task from another company', description: 'Task for another company', company: company2)
    end

    before do
      login_as(user1, scope: :user)
      visit tasks_path
    end

    it 'displays a list of tasks' do
      expect(page).to have_content('Tasks')
      expect(page).to have_content('Test Task 1')
      expect(page).to have_content('Test Task 2')
      expect(page).not_to have_content('Task from another company')
    end

    it 'allows the user to create a new task for their company' do
      click_on 'New Task'

      expect do
        within('#new_task') do
          fill_in 'Name', with: 'New Task for Company 1'
          fill_in 'Description', with: 'New task description for Company 1'
          click_button 'Create'
          sleep 0.5
        end
      end.to change(Task, :count).by(1)

      expect(page).to have_content('Task was successfully created.')
      expect(page).to have_content('New Task for Company 1')
    end

    it 'does not allow user1 to see or manage tasks from another company' do
      expect(page).not_to have_content('Task from another company')
    end

    it 'displays an error when trying to create a task without a name' do
      click_on 'New Task'

      within('#new_task') do
        fill_in 'Name', with: ''
        fill_in 'Description', with: 'Task description without a name'
        click_button 'Create'
      end

      expect(page).to have_content("Name can't be blank")
    end

    it 'allows the user to edit an existing task' do
      within("#task_#{task1.id}") do
        find('a.task_edit').click
      end

      within("#task_#{task1.id}") do
        fill_in 'Name', with: 'Updated Task'
        fill_in 'Description', with: 'Updated task description'
        click_button 'Update'
      end

      expect(page).to have_content('Task was successfully updated.')
      expect(page).to have_content('Updated Task')
    end

    it 'allows the user to delete a task' do
      expect do
        within("#task_#{task1.id}") do
          accept_confirm { find('a.task_delete').click }
          sleep 0.5
        end
      end.to change(Task, :count).by(-1)

      expect(page).to have_content('Task was successfully destroyed.')
      expect(page).not_to have_content('Test Task 1')
    end
  end
end
