class Route
  attr_reader :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def del_station(station)
    if station != @stations[0] && station != @stations[-1]
      @stations.delete(station)
    end
  end
end
