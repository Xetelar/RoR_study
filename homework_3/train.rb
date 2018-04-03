class Train
  attr_accessor :speed
  attr_reader :number_cars

  def initialize(number, type, number_cars)
    @number = number
    @type = type
    @number_cars = number_cars
    @speed = 0
    @station_index = 0
  end

  def accelerate
    @speed += 1
  end

  def stop
    self.speed = 0
  end

  def add_car
    if @speed.zero?
      @number_cars += 1
    end
  end

  def remove_car
    if speed.zero? && @number_cars.length > 0
      @number_cars -= 1
    end
  end

  def add_route(route)
    @route = route
    @station_index = 0
  end

  def move_back
    unless first_station?
      current_station.depart_train(self)
      @station_index -= 1
      current_station.add_train(self)
    end
  end

  def move_next
    unless last_station?
      current_station.depart_train(self)
      @station_index += 1
      current_station.add_train(self)
    end
  end

  def next_station
    @route.stations[@station_index + 1]
  end

  def current_station
    @route.stations[@station_index]
  end

  def prev_station
    if @station_index > 0
      @route.stations[@station_index - 1]
    end
  end

  def last_station?
    current_station == @route.stations[-1]
  end

  def first_station?
    current_station == @route.stations[0]
  end
end
