class Route
  include InstanceCounter
  include Validator

  attr_reader :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
    validate!
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def del_station(station)
    @stations.delete(station) unless [@stations[0], @stations[-1]].include? station
  end

  def print_stations
    puts @stations
  end

  def start_station
    @stations.first
  end

  def finish_station
    @stations.last
  end

  def validate!
    @stations.each do |station|
      unless station.is_a? Station
        raise 'Введенный объект не является объктом класса Station'
      end
    end
    if start_station == finish_station
      raise 'Начальная и конечная станции не могут совпадать'
    end
  end
end
