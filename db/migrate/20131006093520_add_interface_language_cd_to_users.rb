class AddInterfaceLanguageCdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :interface_language_cd, :integer, default: 0
  end
end
