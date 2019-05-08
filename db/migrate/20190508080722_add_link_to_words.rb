class AddLinkToWords < ActiveRecord::Migration[5.2]
  def change
    add_column :words ,:link, :string
  end
end
