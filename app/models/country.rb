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

    def find(id)
      return nil unless data[id.to_s]
      new data[id.to_s]
    end

    def all
      @all ||= data.values.map { |row| new row }
    end

    def where(attributes = {})
      all.select do |province|
        attributes.keys.map do |key|
          next unless province.respond_to?(key)
          expected_value = attributes[key]
          expected_value = [expected_value] unless expected_value.is_a?(Array)
          expected_value.include? province.send(key)
        end.uniq == [true]
      end
    end
  end

  alias id iso_code
end
