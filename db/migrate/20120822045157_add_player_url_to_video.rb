class AddPlayerUrlToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :linkurl, :string

    add_column :videos, :views, :integer

    add_column :videos, :embedcode, :string

  end
end
