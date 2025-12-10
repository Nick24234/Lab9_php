class AddCurrencyToTransfers < ActiveRecord::Migration[7.0]
  def change
    add_column :transfers, :currency, :string
  end
end
