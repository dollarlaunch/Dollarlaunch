class AddFeaturedstatusToCampaigns < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :featuredstatus, :boolean, default: false
  end
end
