class PassengerCar < Car
  def initialize(volume)
    @taken = 0
    super('passenger', volume)
  end

  def add_volume
    super(1)
  end
end
