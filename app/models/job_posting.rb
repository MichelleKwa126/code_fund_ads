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

class JobPosting < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :campaign
  belongs_to :organization
  belongs_to :user

  # validations ...............................................................
  validates :title, length: { within: 2..80 }
  validates :description, presence: true
  validates :job_type, inclusion: { in: ENUMS::JOB_TYPES.keys }
  validates :max_annual_salary_cents, presence: true
  validates :max_annual_salary_currency, presence: true
  validates :min_annual_salary_cents, presence: true
  validates :min_annual_salary_currency, presence: true
  validates :remote, presence: true

  # callbacks .................................................................
  # scopes ....................................................................
  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  # protected instance methods ................................................
  protected

  # private instance methods ..................................................
  private
end
