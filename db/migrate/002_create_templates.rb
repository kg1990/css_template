class CreateTemplates < ActiveRecord::Migration
  def self.up
    create_table :templates do |t|
      t.string :name
      t.string :image_path
      t.string :github_href
      t.string :zip_path
      t.integer :download_count, :default => 0  
      t.timestamps
    end
  end

  def self.down
    drop_table :templates
  end
end
