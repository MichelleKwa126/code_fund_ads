class Country
  include ActiveModel::Model
  attr_accessor :name, :iso_code

  class << self
    def data
      @data ||= begin
        Province.all.each_with_object({}) do |province, memo|
          memo[province.country_code] ||= {name: province.country_name, iso_code: province.country_code}
        end
      end
    end

    def all
      @all ||= data.values.map { |row| new row }
    end
  end

  alias id iso_code
end
