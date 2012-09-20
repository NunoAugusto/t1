class CreatePontinhos < ActiveRecord::Migration
  def change
    create_table :pontinhos do |t|
      t.integer :NumDesenho
      t.integer :NumPonto
      t.integer :CX
      t.integer :CY

      t.timestamps
    end
  end
end
