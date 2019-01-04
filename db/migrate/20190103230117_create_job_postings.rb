class CreateJobPostings < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :boolean, :job_posting, null: false, default: false
    add_column :campaigns, :point, :lonlat
    add_index :campaigns, :job_posting
    add_index :campaigns, :lonlat, spatial: true

    create_table :job_postings do |t|
      t.bigint :organization_id, null: false
      t.bigint :user_id, null: false
      t.bigint :campaign_id, null: false
      t.string :job_type, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.monetize :min_annual_salary, null: false, default: Money.new(75_000, "USD")
      t.monetize :max_annual_salary
      t.boolean :remote, null: false, default: false
      t.string :city
      t.string :state_province
      t.string :country_code
      t.integer :target_radius
      t.text :url
      t.date :start_date
      t.date :end_date
      t.point :lonlat
      t.tsvector :full_text_search
      t.timestamps

      t.index :organization_id
      t.index :user_id
      t.index :campaign_id
      t.index :job_type
      t.index :title
      t.index :min_annual_salary_cents
      t.index :max_annual_salary_cents
      t.index :remote
      t.index :city
      t.index :state_province
      t.index :country_code
      t.index :start_date
      t.index :end_date
      t.index :lonlat, spatial: true
      t.index :full_text_search, using: :gin
    end
  end
end
