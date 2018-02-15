class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.references :user, foreign_key: true
      t.string :subject
      t.text :description
      t.integer :comments_count
      t.integer :likes_count
      t.boolean :secret

      t.timestamps
    end
  end
end
