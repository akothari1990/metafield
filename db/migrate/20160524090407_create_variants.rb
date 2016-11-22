class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.integer :actual_price
      t.string :type
      t.integer :type_price
      t.string :variant_id

      t.timestamps null: false
    end
  end
end
