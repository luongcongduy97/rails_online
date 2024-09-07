# frozen_string_literal: true

# spec/system/tasks_spec.rb

require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  describe 'task page' do
    let!(:task1) { create(:task, name: 'Test Task 1', description: 'Task description 1') }
    let!(:task2) { create(:task, name: 'Test Task 2', description: 'Task description 2') }
    it 'displays a list of tasks' do
      visit tasks_path

      expect(page).to have_content('Tasks')
      expect(page).to have_content('Test Task 1')
      expect(page).to have_content('Test Task 2')
    end

    it 'allows the user to create a new task' do
      visit tasks_path

      click_on 'New Task'

      within('#new_task') do
        fill_in 'Name', with: 'New Task'
        fill_in 'Description', with: 'New task description'
        click_button 'Create'
      end

      expect(page).to have_content('Task was successfully created.')
      expect(page).to have_content('New Task')
    end

    it 'displays an error when trying to create a task without a name' do
      visit tasks_path

      click_on 'New Task'

      within('#new_task') do
        fill_in 'Name', with: ''
        fill_in 'Description', with: 'Task description without a name'
        click_button 'Create'
      end

      expect(page).to have_content("Name can't be blank")
    end

    it 'allows the user to edit an existing task' do
      visit tasks_path

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
      visit tasks_path

      expect do
        within("#task_#{task1.id}") do
          accept_confirm { find('a.task_delete').click }
        end
        sleep 0.5
      end.to change(Task, :count).by(-1)

      expect(page).to have_content('Task was successfully destroyed.')
      expect(page).not_to have_content('Test Task 1')
    end
  end
end
