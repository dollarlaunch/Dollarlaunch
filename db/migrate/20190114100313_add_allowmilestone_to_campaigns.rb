class AddAllowmilestoneToCampaigns < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :allowmilestone, :boolean, default: false
  end
end
