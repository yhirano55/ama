class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.references :user, foreign_key: true, null: false

      t.string  :subject,        null: false
      t.text    :description,    null: false
      t.integer :comments_count, null: false, default: 0
      t.integer :likes_count,    null: false, default: 0
      t.boolean :secret,         null: false, default: false

      t.timestamps
    end
  end
end
