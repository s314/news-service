class AddLinkToReadLaterEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :read_later_entries, :link, :string
  end
end
