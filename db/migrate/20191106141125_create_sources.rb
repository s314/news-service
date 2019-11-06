class CreateSources < ActiveRecord::Migration[5.2]
  def change
    create_table :sources do |t|
      t.string :title
      t.string :address

      t.timestamps
    end
  end
end
