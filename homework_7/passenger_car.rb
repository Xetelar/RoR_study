class PassengerCar < Car
  def initialize(volume)
    @take_volume = 0
    super('passenger', volume)
  end

  def add_volume
    @take_volume += 1 if @take_volume < @volume
  end

  def no_take_place
    @volume - @take_volume
  end
end
