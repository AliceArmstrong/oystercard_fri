require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { { "entry" => entry_station, "exit" => exit_station} }

  describe "initialization" do
    it "should has a balance of 0" do
      expect(oystercard.balance).to eq 0
    end
  end

  describe '#top_up' do

    it {is_expected.to respond_to(:top_up).with(1).argument}

    it "can top_up the balance" do
      expect{ oystercard.top_up(10)}.to change { oystercard.balance }.by 10
    end

    it "should raise an error if balance is greater than 90" do
      expect{oystercard.top_up(100)}.to raise_error "You can't have a balance more than 90!"
    end

    it "should raise an error if balance is exceeded" do
      oystercard.top_up(Oystercard::MAX_BALANCE)
      expect{oystercard.top_up(1)}.to raise_error "You can't have a balance more than 90!"
    end
  end

  describe "touching in and out" do

    before :each do
      oystercard.top_up(10)
      oystercard.touch_in(Station.new 'Nottinghill')
    end

  describe "#touch_out" do

    it "should deduct the fee" do
      expect{oystercard.touch_out(Station.new ('Aldgate'))}.to change {oystercard.balance}.by -Oystercard::MIN_FARE
    end
  end

  end

  it "should raise an error if balance is less than £#{Oystercard::MIN_FARE}" do
    expect{oystercard.touch_in(entry_station)}.to raise_error "Your balance is less than #{Oystercard::MIN_FARE}!"
  end

  context 'raising a penalty fare' do

  it 'charges penalty fare if not tapped in' do
    journey.end_journey(Station.new "Aldgate")
    expect(oystercard.fare_checker).to eq oystercard.penalty_fare

  it 'charges penalty fare if tapped in twice' do
    journey.start_journey(Station.new "Aldgate")
    expect(journey.start_journey(Station.new "Aldgate")).to eq oystercard.penalty_fare
  end
end
end
end
