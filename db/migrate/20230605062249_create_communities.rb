class CreateCommunities < ActiveRecord::Migration[6.1]
  def change
    create_table :communities do |t|
      t.string :name, null: false
      t.string :ancestry

      t.timestamps
    end
  end
end
