class AddClosingToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :closing, :date
  end
end
