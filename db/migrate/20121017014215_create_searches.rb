class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :keywords
      t.string :channel_type
      t.string :tags
      t.string :categories
      t.string :language

      t.timestamps
    end
  end
end
