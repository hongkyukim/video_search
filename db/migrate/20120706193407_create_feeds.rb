class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :name
      t.string :feedtype
      t.string :queries
      t.string :options
      t.string :keywords
      t.string :tags
      t.string :categories

      t.timestamps
    end
  end
end
