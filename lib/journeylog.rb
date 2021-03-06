require_relative 'oystercard'

class JourneyLog

attr_reader :entry_station, :exit_station, :journeys, :current_journey

  def initialize
    @entry_station = nil
    @exit_station = nil
    @journeys = []
    @current_journey = current_journey
  end

  def show_journey_history
    p @journeys
  end

  def start_journey(station)
    @entry_station = station
  end

  def end_journey(station)
    @exit_station = station
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
