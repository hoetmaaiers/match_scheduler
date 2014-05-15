class AddTypeToRound < ActiveRecord::Migration
  def change
    add_column :rounds, :type, :string
    add_column :rounds, :order, :integer
  end
end
