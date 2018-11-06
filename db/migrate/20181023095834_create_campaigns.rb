class CreateCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :campaigns do |t|
      t.string :title
      t.text :blurb
      t.text :description
      t.attachment :image
      t.text :location
      t.integer :duration
      t.integer :goal
      t.integer :pledge_amount
      t.integer :no_of_participants
      t.integer :status, default: 0
      t.date :pledge_deadline
      
      t.references :category, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
