require_relative 'instance_counter.rb'
require_relative 'company_accessor.rb'
require_relative 'validator.rb'

class Train
  include CompanyAccessor
  include InstanceCounter
  include Validator

  attr_reader :speed, :cars

  @@trains = {}

  NUMBER_FORMAT = /^([a-z]|\d){3}-?([a-z]|\d){2}$/i
  TYPE_FORMAT = /^(cargo|passenger)$/i

  def self.find(number)
    @@trains[number]
  end

  def initialize(number, type)
    @number = number
    @type = type
    @cars = []
    @speed = 0
    @station_index = 0

    validate!

    @@trains[number] = self

    register_instance
  end

  def accelerate(value)
    @speed += value if value > 0
  end

  def stop(value)
    new_speed = @speed - value
    @speed = new_speed > 0 ? new_speed : 0
  end

  def add_car(car)
    @cars << car if @speed.zero? && @type == car.type
  end

  def remove_car(car)
    @cars.delete(car) if speed.zero? && !@cars.empty?
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

  def last_station?
    current_station == @route.stations[-1]
  end

  def first_station?
    current_station == @route.stations[0]
  end

  protected

  def validate!
    raise 'Не правильный номер поезда' if @number !~ NUMBER_FORMAT
    raise 'Не правильный тип поезда' if @type !~ TYPE_FORMAT
  end
end
