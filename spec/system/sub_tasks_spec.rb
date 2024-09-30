# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sub Task', type: :system do
  let!(:company1) { create(:company, name: 'Existing Company 1') }
  let!(:user) { create(:user, email: 'user@example.com', password: 'password123', company: company1) }
  let!(:task1) { create(:task, name: 'Test Task 1', description: 'Task description 1', company: company1) }
  let!(:sub_task) { create(:sub_task, task: task1) }

  before do
    login_as(user, scope: :user)
    visit "/tasks/#{task1.id}"
  end

  describe 'SubTask#create' do
    it 'allows creating' do
      click_on 'New sub task'
      expect do
        within('#new_sub_task') do
          fill_in 'Due date', with: Date.current + 1.day
          click_on 'Create'
          sleep 0.5
        end
      end.to change { SubTask.count }.by(1)

      expect(page).to have_content('Sub task was successfully created.')
    end

    it 'shows errors when due date is not unique within the task' do
      existing_due_date = sub_task.due_date
      click_on 'New sub task'
      expect do
        within('#new_sub_task') do
          fill_in 'Due date', with: existing_due_date
          click_on 'Create'
          sleep 0.5
        end
      end.not_to(change { SubTask.count })

      expect(page).to have_content('Due date already exists for this task')
    end

    it 'shows errors when due date is blank' do
      click_on 'New sub task'
      expect do
        within('#new_sub_task') do
          fill_in 'Due date', with: ''
          click_on 'Create'
          sleep 0.5
        end
      end.not_to(change { SubTask.count })

      expect(page).to have_content("Due date can't be blank")
    end
  end

  describe 'SubTask#update' do
    it 'allows update' do
      within("#sub_task_#{sub_task.id}") do
        find('a.sub_task_edit').click
      end

      expect do
        within("#sub_task_#{sub_task.id}") do
          fill_in 'Due date', with: Date.current + 1.day
          click_on 'Update'
          sleep 0.5
        end
      end.to change { SubTask.count }.by(0)

      expect(page).to have_content('Sub task was successfully updated.')
    end
  end

  describe 'SubTask#destroy' do
    it 'allows destroy' do
      expect do
        within("#sub_task_#{sub_task.id}") do
          accept_confirm { find('a.sub_task_delete').click }
          sleep 0.5
        end
      end.to change { SubTask.count }.by(-1)

      expect(page).to have_content('Sub task was successfully destroyed.')
    end
  end
end
