class Train
  attr_reader :speed, :cars

  def initialize(number, type)
    @number = number
    @type = type
    @cars = []
    @speed = 0
    @station_index = 0
  end

  def accelerate(value)
    @speed += value if value > 0
  end

  def stop(value)
    @speed = if @speed > 0
               @speed - value
             else
               0
             end
  end

  def add_car(car)
    if @speed.zero? && (@cars.empty? || last_car_type? == car.type)
      @cars << car
    end
  end

  def remove_car
    @cars.pop if speed.zero? && !@cars.empty?
  end

  def add_route(route)
    @route = route
    @station_index = 0
    current_station.add_train(self)
  end

  def move_back
    unless first_station?
      current_station.send_train(self)
      @station_index -= 1
      current_station.add_train(self)
    end
  end

  def move_next
    unless last_station?
      current_station.send_train(self)
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
    @route.stations[@station_index - 1] if @station_index > 0
  end

  def last_car_type?
    @cars[@cars.length - 1].type
  end

  def last_station?
    current_station == @route.stations[-1]
  end

  def first_station?
    current_station == @route.stations[0]
  end
end
