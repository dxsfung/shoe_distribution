class CreateShoeShops < ActiveRecord::Migration
  def change
  	create_table(:shoe_shops) do |t|
        t.column(:name, :string)
        t.timestamps
      end
  end
end
