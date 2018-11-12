class CreateProjectchampions < ActiveRecord::Migration[5.2]
  def change
    create_table :projectchampions do |t|
      t.integer :projectchampiontotalamount
      t.integer :projectchampionpaidamount
      
      t.references :campaign, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
