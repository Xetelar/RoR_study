class Station
  attr_reader :trains, :name

  @stantions = []

  def self.all
    @stantions
  end

  def initialize(name)
    @name = name
    @trains = []

    @stantions << self
  end

  def add_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    trains.select { |train| train.type == type }
  end
end
