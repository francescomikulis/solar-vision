class CreateAppliances < ActiveRecord::Migration
  def change
    create_table :appliances do |t|
      t.string :name
      t.float :power
      t.integer :average_time
      t.boolean :all_day

      t.timestamps null: false
    end
  end
end
