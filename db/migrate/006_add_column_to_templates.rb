class AddColumnToTemplates < ActiveRecord::Migration
  def self.up
    add_column :templates, :view_count, :integer, :default => 0
    add_column :templates, :source_type, :string, :default => 'html'
    add_column :templates, :style_type, :string, :default => '欧美'
    add_column :templates, :file_length, :double, :default => 0
    add_column :templates, :come_form, :string, :default => '网络'
  end

  def self.down
  end
end
