class CreateBackerinvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :backerinvoices do |t|
      t.string :amount
      t.string :captureid
      
      t.references :backer, foreign_key: true

      t.timestamps
    end
  end
end
