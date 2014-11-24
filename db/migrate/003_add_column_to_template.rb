class AddColumnToTemplate < ActiveRecord::Migration
  def self.up
    add_column :templates, :desc, :text
  end

  def self.down
  end
end
