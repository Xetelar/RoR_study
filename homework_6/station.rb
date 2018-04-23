class Station
  include InstanceCounter

  attr_reader :trains, :name

  @@stantions = []

  NAME_FORMAT = /^[a-z]+\d*$/i

  def self.all
    @@stantions
  end

  def initialize(name)
    @name = name
    @trains = []

    validate!

    @@stantions << self
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

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise 'Не правильный имя' if name !~ NAME_FORMAT
    true
  end
end
