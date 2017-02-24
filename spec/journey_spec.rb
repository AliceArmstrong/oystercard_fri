require 'journey'
require 'journeylog'

  describe Journey do

  journeylog = JourneyLog.new
  journeylog.start_journey(Station.new 'Nottinghill gate', 3)
  journeylog.end_journey(Station.new 'Richmond', 4)
  journey = Journey.new(journeylog.entry_station, journeylog.exit_station)
  
  it 'checks to see if it calculates the correct fare', :focus do
    expect(journey.fare_calculator).to eq 2
  end

end
