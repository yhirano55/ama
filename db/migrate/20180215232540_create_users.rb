class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :uid
      t.string :nickname
      t.string :image_url
      t.integer :role
      t.integer :comments_count
      t.integer :likes_count
      t.string :remember_token

      t.timestamps
    end
  end
end
