class Route
  include InstanceCounter
  include Validation

  attr_reader :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
    validate!
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def del_station(station)
    stations_include = [@stations[0], @stations[-1]].include? station
    @stations.delete(station) unless stations_include
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
      break if station.is_a? Station
      raise 'Введенный объект не является объктом класса Station'
    end
    return unless start_station == finish_station
    raise 'Начальная и конечная станции не могут совпадать'
  end
end
