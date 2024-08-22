# frozen_string_literal: true

# spec/system/tasks_spec.rb

require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  describe 'task page' do
    it 'displays a list of tasks' do
      Task.create!(name: 'Test Task 1', description: 'Task description 1')
      Task.create!(name: 'Test Task 2', description: 'Task description 2')

      visit tasks_path

      expect(page).to have_content('Tasks')
      expect(page).to have_content('Test Task 1')
      expect(page).to have_content('Test Task 2')
    end

    it 'allows the user to create a new task' do
      visit new_task_path

      fill_in 'Name', with: 'New Task'
      fill_in 'Description', with: 'New task description'
      click_button 'Create Task'

      expect(page).to have_content('Task was successfully created.')
      expect(page).to have_content('New Task')
    end

    it 'allows the user to edit an existing task' do
      task = Task.create!(name: 'Edit Task', description: 'Task description')

      visit edit_task_path(task)

      fill_in 'Name', with: 'Updated Task'
      fill_in 'Description', with: 'Updated task description'
      click_button 'Update Task'

      expect(page).to have_content('Task was successfully updated.')
      expect(page).to have_content('Updated Task')
    end

    it 'allows the user to delete a task' do
      Task.create!(name: 'Delete Task', description: 'Task description')

      visit tasks_path

      expect do
        accept_confirm { click_on 'Delete' }
        sleep 0.5
      end.to change(Task, :count).by(-1)

      expect(page).to have_content('Task was successfully destroyed.')
    end
  end
end
