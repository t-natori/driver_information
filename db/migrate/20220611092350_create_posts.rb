class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :customer_id
      t.integer :genre_id
      t.string :name, null: false
      t.string :address, null: false
      t.float :latitude #緯度
      t.float :longitude #経度
      t.integer :category
      t.float :recommend, null: false
      t.float :clean, null: false
      t.integer :parking
      t.text :detail
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
