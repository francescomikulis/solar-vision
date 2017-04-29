class CreatePanels < ActiveRecord::Migration
  def change
    create_table :panels do |t|
      t.string :name
      t.float :power

      t.timestamps null: false
    end
  end
end
