class RenameColumnToVariant < ActiveRecord::Migration
  def change
  	rename_column :variants, :type, :wood_type
  end
end
