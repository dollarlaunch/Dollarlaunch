class CreateMilestoneupdates < ActiveRecord::Migration[5.2]
  def change
    create_table :milestoneupdates do |t|
      t.references :milestone, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
