class CreateAdministradors < ActiveRecord::Migration[7.0]
  def change
    create_table :administradors do |t|
      t.string :Nome
      t.string :Email
      t.string :Senha

      t.timestamps
    end
  end
end
