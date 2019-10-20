class CreateReadLaterEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :read_later_entries do |t|
      t.string :title
      t.datetime :date
      t.text :description
      t.string :image
      t.belongs_to :user

      t.timestamps
    end
  end
end
q