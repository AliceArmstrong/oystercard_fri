require_relative 'oystercard'

class Journey

attr_reader :entry_station, :exit_station, :journeys, :current_journey

  def initialize
    @entry_station = nil
    @exit_station = nil
    @journeys = []
  end

  def start_journey(station)
    @entry_station = station.name
  end

  def end_journey(station)
    @exit_station = station.name
    save_journey
  end

  def invalid_journey?
    @entry_station == nil || @exit_station == nil
  end

  def reset_journey
    @entry_station = nil
    @exit_station = nil
  end

  def save_journey
    @current_journey = { "entry" => @entry_station, "exit" => @exit_station}
    @journeys << @current_journey
  end

  def journey_complete?
    @entry_station == nil && @exit_station == nil
  end

end
