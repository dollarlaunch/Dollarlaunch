class CreateRiskandchallenges < ActiveRecord::Migration[5.2]
  def change
    create_table :riskandchallenges do |t|
      t.text :description

      t.references :campaign, foreign_key: true
      
      t.timestamps
    end
  end
end
