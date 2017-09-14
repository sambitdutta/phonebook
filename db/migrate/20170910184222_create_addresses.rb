class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :pin_code
      t.string :state
      t.belongs_to :country, foreign_key: true

      t.timestamps
    end
  end
end
