class CreateDomains < ActiveRecord::Migration
  def self.up
    create_table :domains do |t|
      t.string :domain
      t.string :response
      t.boolean :can_use, :default => false
      t.boolean :checked, :default => false 
      t.timestamps
    end
  end

  def self.down
    drop_table :domains
  end
end
