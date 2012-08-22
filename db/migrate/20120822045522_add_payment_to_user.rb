class AddPaymentToUser < ActiveRecord::Migration
  def change
    add_column :users, :payment, :integer

  end
end
