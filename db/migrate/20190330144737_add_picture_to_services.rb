class AddPictureToServices < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :picture, :string
  end
end
