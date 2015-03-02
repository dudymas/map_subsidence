class AddLatLongToSubsidence < ActiveRecord::Migration
  def change
    add_column :subsidences, :latitude, :decimal
    add_column :subsidences, :longitude, :decimal
  end
end
