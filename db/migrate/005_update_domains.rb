class UpdateDomains < ActiveRecord::Migration
  def self.up
    change_column(:domains, :response, :text)
  end

  def self.down
  end
end
