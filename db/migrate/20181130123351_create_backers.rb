class CreateBackers < ActiveRecord::Migration[5.2]
  def change
    create_table :backers do |t|
      t.string :pledgeamountperperson
      t.string :eachmilestoneamount
      t.boolean :paymentstatus, default: false
      t.string :paymentid, null: true
      t.string :payerid, null: true
      t.string :token, null: true
      t.string :authorization, null: true
      
      t.references :user, foreign_key: true
      t.references :campaign, foreign_key: true
      
      t.timestamps
    end
  end
end
