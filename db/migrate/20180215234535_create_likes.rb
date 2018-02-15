class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user,     foreign_key: true, null: false, index: false
      t.references :likeable, polymorphic: true, null: false, index: true

      t.timestamps
    end

    add_index :likes, [:user_id, :likeable_type, :likeable_id], unique: true, name: "index_likes_for_uniqueness"
  end
end
