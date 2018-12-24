class CreateCampaignreviews < ActiveRecord::Migration[5.2]
  def change
    create_table :campaignreviews do |t|
      t.references :user, foreign_key: true
      t.references :campaign, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
