class AddAmountToPeople < ActiveRecord::Migration[7.1]
  def change
    add_column :people, :amount, :decimal
  end
end
