class CreateMilestones < ActiveRecord::Migration[5.2]
  def change
    create_table :milestones do |t|
      t.string :title
      t.text :description
      t.integer :duration_type
      t.integer :duration_limit
      t.integer :budget
      t.attachment :video
      
      t.references :campaign, foreign_key: true

      t.timestamps
    end
  end
end