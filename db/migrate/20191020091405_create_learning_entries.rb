class CreateLearningEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :learning_entries do |t|
      t.string :title
      t.text :description
      t.string :category

      t.timestamps
    end
  end
end
