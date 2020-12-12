class RemoveStreet2FromApplications < ActiveRecord::Migration[5.2]
  def change
    remove_column :applications, :street_2, :string
    rename_column :applications, :street_1, :street
    add_column :applications, :status, :integer, :default => 0
  end
end
