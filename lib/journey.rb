require_relative 'oystercard'

class Journey

attr_reader :entry_station, :exit_station, :journeys, :current_journey

  def initialize
    @entry_station = nil
    @exit_station = nil
    @journeys = []
  end


  def start_journey(station)
    # if !journey_complete?
    #   oystercard.penalty_fare #moving to oystercard
    # end
    @entry_station = station.name
  end

  def end_journey(station)
    @exit_station = station.name
    # fare_checker #moving to oystercard
    save_journey
    # @entry_station = nil
    # @exit_station
  end

  def invalid_journey?
    @entry_station == nil || @exit_station == nil
  end

  def reset_journey
    @entry_station = nil
    @exit_station = nil
    # @exit_station
  end

  def save_journey
    @current_journey = { "entry" => @entry_station, "exit" => @exit_station}
    @journeys << @current_journey
  end

  def journey_complete?
    @entry_station == nil && @exit_station == nil
  end

  # def fare_checker #move to oystercard
  #     if @entry_station == nil || @exit_station == nil
  #       penality_fare
  #     else
  #       min_fare #will want this to call in oystercard
  #     end
  # end
  #
  # def penalty_fare #move to oystercard
  #   @oystercard = Oystercard.new
  #   @oystercard.penalty_fare
  #   Oystercard::PENALTY_FARE
  # end
  #
  # def min_fare #move to oystercard
  #   @oystercard = Oystercard.new
  #   @oystercard.min_fare
  #   Oystercard::MIN_FARE
  # end


end
