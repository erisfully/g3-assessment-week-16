require 'spec_helper'

describe 'Tracker' do

  it 'takes a file as an argument' do
    Tracker.new("./data/metrics.tsv")
  end

  it 'returns a hash with the averages for each container' do
    tracker = Tracker.new("./data/metrics.tsv")
    averages_hash = tracker.compute_averages("container1")
    expected_output = {:pH => 5.01, :nutrients => 39.02, :temp => 57.76, :water_level => 2.12}
    expect(averages_hash).to eq(expected_output)
  end
end