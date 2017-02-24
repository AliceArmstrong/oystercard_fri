class Station

  attr_reader :name, :zone

  def initialize(name, zone)
    @name = name.capitalize
    @zone = zone.to_i
  end

end
