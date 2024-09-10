class AddCompanyReferenceToTasks < ActiveRecord::Migration[7.1]
  def change
    add_reference :tasks, :company, null: false, foreign_key: true
    add_reference :users, :company, null: false, foreign_key: true
  end
end
