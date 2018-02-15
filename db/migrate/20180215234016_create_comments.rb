class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user,  foreign_key: true, null: false
      t.references :issue, foreign_key: true, null: false

      t.text    :content,     null: false
      t.integer :likes_count, null: false, default: 0
      t.boolean :secret,      null: false, default: false

      t.timestamps
    end
  end
end
