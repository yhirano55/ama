class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :issue, foreign_key: true
      t.text :content
      t.integer :likes_count
      t.boolean :secret

      t.timestamps
    end
  end
end
