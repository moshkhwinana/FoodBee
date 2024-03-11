class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :product_name
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
