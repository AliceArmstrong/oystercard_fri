require 'journeylog'

describe JourneyLog do

  subject(:journeylog) { described_class.new }

    it 'checks if journey is complete' do
      expect(subject.journey_complete?).to eq true
    end

    it 'should have an empty list of journeys by default' do
      expect(subject.journeys). to eq []
    end

    it 'starts a journey' do
     expect(subject.start_journey(Station.new "Aldgate", 1)).to eq subject.entry_station
    end

    context 'touch in and out methods on journey' do

    before (:each) do
      subject.start_journey(Station.new "Aldgate", 1)
    end


  it "should store journey details (entry and exit stations)" do
    subject.end_journey(Station.new "Nottinghill gate", 3)
    expect(subject.journeys).to include subject.current_journey
  end

  it "should forget entry station after touching out" do
    subject.end_journey(Station.new "Nottinghill gate", 3)
    expect(subject.reset_journey).to eq nil
  end

end

  # context 'raising a penalty fare' do #move to oystercard spec
  #
  # it 'charges penalty fare if not tapped in' do
  #   journey.end_journey(Station.new "Aldgate", 1)
  #   expect(journey.fare_checker).to eq journey.penalty_fare #will want this to call in oystercard
  # end
  #
  # it 'charges penalty fare if tapped in twice' do
  #   journey.start_journey(Station.new "Aldgate", 1)
  #   expect(journey.start_journey(Station.new "Aldgate", 1)).to eq journey.penalty_fare
  # end
  #
  # it 'checks to see if regular fare '
  # end
end
