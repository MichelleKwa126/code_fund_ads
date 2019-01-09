class AddSubdivisionTargeting < ActiveRecord::Migration[5.2]
  def change
    add_column :impressions, :province_code, :string
    add_index :impressions, :province_code

    add_column :campaigns, :provinces, :string, default: [], array: true
    add_index :campaigns, :provinces, using: :gin
  end
end
