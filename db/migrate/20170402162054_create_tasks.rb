class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.datetime :deadline
      t.boolean :completed, default: false
      t.integer :priority
      t.timestamps
    end
    add_reference :tasks, :project, index: true, foreign_key: true
  end
end
