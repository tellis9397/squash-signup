class RemoveTvHelperTables < ActiveRecord::Migration[5.0]
  def change
  	drop_table :tv_shows
  	drop_table :user_shows
  end
end
