class CreateUserListTable < ActiveRecord::Migration
  
  def change
    create_table :user_list do |t|
      t.string  :feature,    :null => false # MyFeatureX
      t.string  :identifier, :null => false # Usr-123
      t.integer :list,       :null => false , :default => 0 # enum
      t.timestamps
    end
  end
end

