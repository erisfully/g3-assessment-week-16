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
    ph_array = parse_file[container].map {|reading| reading[2].to_f}
    ave_ph = ph_array.inject{|sum, x| sum + x}/ph_array.length
    averages_hash['pH'] = ave_ph.round(2)
  end
end