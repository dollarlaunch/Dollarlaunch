class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.attachment :image
      
      t.references :owner, polymorphic: true
      t.timestamps
    end
  end
end
