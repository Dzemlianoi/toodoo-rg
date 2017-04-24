class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.timestamps
    end
    add_reference :projects, :user, index: true, foreign_key: true
  end
end
