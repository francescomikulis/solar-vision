class AddTrackingToPanel < ActiveRecord::Migration
  def change
    add_column :panels, :tracking, :boolean
  end
end
