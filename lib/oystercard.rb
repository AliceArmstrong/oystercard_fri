require_relative 'station'
require_relative 'journey'

class Oystercard

  MAX_BALANCE = 90
  MIN_FARE = 1
  PENALTY_FARE = 6

  attr_reader :balance, :journey_one

  def initialize
    @balance = 0
    @journey = Journey.new
  end

  def top_up(amount)
    raise "You can't have a balance more than #{MAX_BALANCE}!" if balance_over_maximum?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "Your balance is less than #{MIN_FARE}!" if @balance < MIN_FARE
      if !@journey.journey_complete?
        penalty_fare #moving to oystercard
      end
    @journey.start_journey(station)
  end

  def touch_out(station)
    @journey.end_journey(station)
    fare_checker
    @journey.reset
  end

  def fare_checker #move to oystercard
      if @journey.invalid_journey?
        penality_fare
      else
        min_fare #will want this to call in oystercard
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
    #journey.farecheck
    @balance -= fee
  end

  def balance_over_maximum?(amount)
    @balance + amount > MAX_BALANCE
  end

end
