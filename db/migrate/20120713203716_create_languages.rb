class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name
      t.string :fullname
      t.string :shortname

      t.timestamps
    end
  end
end
