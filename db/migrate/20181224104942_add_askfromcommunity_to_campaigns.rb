class AddAskfromcommunityToCampaigns < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :askfromcommunity, :string
  end
end
