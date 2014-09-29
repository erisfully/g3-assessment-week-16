require 'csv'
require 'pp'

class Tracker
  def initialize(file)
    @file = file
  end

  def parse_file
    container_hash = {}
    CSV.foreach(@file, {:col_sep => '\t'}) do |row|
      reading = row[0].split("\t")
      if container_hash.has_key?(reading[1])
        container_hash[reading[1]] << reading
      else
        container_hash[reading[1]] = [reading]
      end
    end
    container_hash
  end

  def compute_averages(container)
    averages_hash = {}

    ph_array = parse_file[container].map { |reading| reading[2].to_f }
    ave_ph = ph_array.inject { |sum, x| sum + x }/ph_array.length
    averages_hash[:pH] = ave_ph.round(2)

    nutrient_array = parse_file[container].map { |reading| reading[3].to_f }
    ave_nutrients = nutrient_array.inject { |sum, x| sum + x }/nutrient_array.length
    averages_hash[:nutrients] = ave_nutrients.round(2)

    temp_array = parse_file[container].map { |reading| reading[4].to_f }
    ave_temp = temp_array.inject { |sum, x| sum + x }/temp_array.length
    averages_hash[:temp] = ave_temp.round(2)

    water_array = parse_file[container].map { |reading| reading[5].to_f }
    ave_water = water_array.inject { |sum, x| sum + x }/water_array.length
    averages_hash[:water_level] = ave_water.round(2)

    averages_hash
  end
end