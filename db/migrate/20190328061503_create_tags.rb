class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end

    create_table :posts_tags do |t|
      t.references :post, foreign_key: true
      t.references :tag, foreign_key: true
    end
  end
end
