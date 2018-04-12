class Route
  attr_reader :stations

  def initialize(start_station, finish_station, name = '')
    @stations = [start_station, finish_station]
    @name = name
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
end
