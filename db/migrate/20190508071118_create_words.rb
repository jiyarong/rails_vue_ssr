class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table :words do |t|
      t.string :text
      t.string :result
      t.integer :status, default: 0
      t.jsonb :dict

      t.timestamps
    end
  end
end
