class FixColumnNameInPontinhos < ActiveRecord::Migration
  def up
  	rename_column :pontinhos, :NumDesenho, :desenhozinho_id
  end

  def down
  end
end
