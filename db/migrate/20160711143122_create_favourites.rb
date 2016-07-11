class CreateFavourites < ActiveRecord::Migration[5.0] # :nodoc:
  def up
    create_table :favourites, id: false do |t|
      t.primary_key :number
      t.boolean :marked, default: false

      t.timestamps
    end

    change_column :favourites, :number, :integer
  end

  def down
    drop_table :favourites
  end
end
