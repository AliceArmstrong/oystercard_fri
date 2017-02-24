require_relative 'station'
require_relative 'journey'
require_relative 'journeylog'

class Oystercard

  MAX_BALANCE = 90
  MIN_FARE = 1
  PENALTY_FARE = 6

  attr_reader :balance, :journey_one

  def initialize
    @balance = 0
    @journeylog = JourneyLog.new
  end

  def top_up(amount)
    raise "You can't have a balance more than #{MAX_BALANCE}!" if balance_over_maximum?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "Your balance is less than #{MIN_FARE}!" if @balance < MIN_FARE
      if !@journeylog.journey_complete?
        penalty_fare
      end
    @journeylog.start_journey(station)
  end

  def touch_out(station)
    @journeylog.end_journey(station)
    fare_checker
    @journeylog.reset_journey
  end

  def fare_checker
      if @journeylog.invalid_journey?
        penality_fare
      else
        min_fare
      end
  end

  def penality_fare
    deduct(PENALTY_FARE)
  end

  def min_fare
    deduct(MIN_FARE)
  end

  private

  def deduct(fee)
    @balance -= fee
  end

  def balance_over_maximum?(amount)
    @balance + amount > MAX_BALANCE
  end

end
