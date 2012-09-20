class CreateDesenhozinhos < ActiveRecord::Migration
  def change
    create_table :desenhozinhos do |t|
      t.integer :NumDesenho_id
      t.string :NomeDesenho

      t.timestamps
    end
  end
  
end
