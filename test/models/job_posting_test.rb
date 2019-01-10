# == Schema Information
#
# Table name: job_postings
#
#  id                         :bigint(8)        not null, primary key
#  organization_id            :bigint(8)        not null
#  user_id                    :bigint(8)        not null
#  campaign_id                :bigint(8)        not null
#  job_type                   :string           not null
#  title                      :string           not null
#  description                :text             not null
#  keywords                   :string           default([]), not null, is an Array
#  min_annual_salary_cents    :integer          default(0), not null
#  min_annual_salary_currency :string           default("USD"), not null
#  max_annual_salary_cents    :integer          default(0), not null
#  max_annual_salary_currency :string           default("USD"), not null
#  remote                     :boolean          default(FALSE), not null
#  city                       :string
#  province_name              :string
#  province_code              :string
#  country_code               :string
#  url                        :text
#  start_date                 :date
#  end_date                   :date
#  full_text_search           :tsvector
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

require "test_helper"

class JobPostingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
