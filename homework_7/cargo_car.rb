class CargoCar < Car
  def initialize(volume)
    super('cargo', volume)
  end

  def add_volume(value)
    new_take_volume = @take_volume += value
    @take_volume = new_take_volume < volume ? volume : new_take_volume
  end

  def allowable_volume
    @volume - @take_volume
  end
end
