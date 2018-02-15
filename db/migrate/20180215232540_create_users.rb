class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :uid,            null: false, index: { unique: true }
      t.string  :nickname,       null: false
      t.string  :image_url,      null: true
      t.integer :role,           null: false, default: 0, limit: 1
      t.integer :comments_count, null: false, default: 0
      t.integer :likes_count,    null: false, default: 0
      t.string  :remember_token, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
