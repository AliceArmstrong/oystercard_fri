class Journey

  def initialize(entry_station, exit_station)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def fare_calculator
    fare = ((@entry_station.zone - @exit_station.zone).abs) +1
  end

end
