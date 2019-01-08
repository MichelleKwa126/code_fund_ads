class Province
  include ActiveModel::Model
  attr_accessor :country_name, :country_code, :province_name, :subdivision

  class << self
    def data
      @data ||= begin
        rows = JSON.parse(File.read(Rails.root.join("db/provinces.json")))
        rows.each_with_object({}) do |row, memo|
          memo["#{row["country_code"]}-#{row["subdivision"]}"] = row
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
      permitted = ActionController::Parameters.new(attributes).
        permit(:country_name, :country_code, :province_name, :subdivision, :iso_code)
      all.select do |province|
        permitted.keys.map { |key| province.send(key) == permitted[key] }.uniq == [true]
      end
    end
  end

  def iso_code
    "#{country_code}-#{subdivision}"
  end

  alias id iso_code
  alias name province_name

  def country
    # TODO
  end

  def persisted?
    true
  end

  def readonly?
    true
  end
end
