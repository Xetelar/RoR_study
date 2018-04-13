require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'car.rb'
require_relative 'cargo_car.rb'
require_relative 'passenger_car.rb'

class Main
  attr_reader :stations, :trains, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def start
    loop do
      puts "
        Выберите действие:
        1  - Создать станцию
        2  - Создать поезд
        3  - Создать маршрут
        4  - Добавить станцию в маршрут
        5  - Удалить станцию из маршрута
        6  - Назначить маршрут поезду
        7  - Добавить вагон к поезду
        8  - Отцепить вагон от поезда
        9  - Переместить поезд вперед по маршруту
        10 - Переместить поезд назад по маршруту
        11 - Посмотреть список станций
        12 - Посмотреть список поездов на станции
        0  - Выход"
      command = gets.to_i

      break if command.zero?

      case_command(command)
    end
  end

  protected

  # Все методы вынес в protected чтобы пользователь не мог менять менять параметры напрямую, не используя меню

  def case_command(command)
    case command
    when 1
      create_station

    when 2
      create_train

    when 3
      create_route

    when 4
      add_station_to_route

    when 5
      del_station_to_route

    when 6
      add_route_to_train

    when 7
      add_car_to_train

    when 8
      del_car_from_train

    when 9
      train_move_next

    when 10
      train_move_back

    when 11
      show_list_of_stations

    when 12
      show_list_of_trains_on_station

    else
      puts 'Введите число от 0 до 12'
    end
  end

  def create_station
    puts 'Введите название станции: '
    name = gets.chomp

    if @stations.find { |station| station.name == name }
      puts 'Станция уже существует'
    else
      station = Station.new(name)
      @stations << station
      puts 'Создана новая станция'
    end
  end

  def create_train
    puts 'Введите номер поезда'
    number = gets.chomp

    loop do
      puts 'Выберите тип поезда:
          1 - Пассажирский
          2 - Грузовой
          0 - Выход'
      type = gets.to_i

      break if type.zero?

      case type
      when type == 1
        trains << PassengerTrain.new(number)
      when type == 2
        trains << CargoTrain.new(number)
      else
        puts 'Выберите тип поезда'
      end
    end
  end

  def create_route
    start_station = choose_station
    finish_station = choose_station

    route = Route.new(start_station, finish_station)
    @routes << route

    route
  end

  def choose_station
    return create_station if @stations.length.zero?

    puts 'Выберите станцию: '
    @stations.each_with_index do |station, i|
      puts "#{i + 1}: #{station.name}"
    end

    station_number = gets.to_i - 1

    @stations[station_number]
  end

  def choose_route
    return create_route if @routes.length.zero?

    print 'Выберите маршрут:'
    @routes.each_with_index do |route, i|
      puts "#{i + 1}: #{route.start_station} - #{route.finish_station}"
    end

    route_number = gets.to_i - 1

    @routes[route_number]
  end

  def choose_train
    return create_train if trains.length.zero?

    print 'Выберите поезд:'

    @trains.each_with_index do |train, i|
      puts "#{i + 1}: #{train.number}"
    end

    train_number = gets.to_i - 1

    @trains[train_number]
  end

  def add_station_to_route
    station = choose_station
    route = choose_route

    route.add_station(station)
  end

  def del_station_to_route
    station = choose_station
    route = choose_route

    route.delete(station)
  end

  def add_route_to_train
    train = choose_train
    route = choose_route

    train.add_route(route)
  end

  def add_car_to_train
    train = choose_train
    car = create_car

    train.add_car(car)
  end

  def del_car_from_train
    train = choose_train
    puts 'Введите номер вагона: '
    car_number = gets.to_i

    train.remove_car(car_number)
  end

  def create_car
    loop do
      puts 'Введите тип вагона
          1 - Пассажирский
          2 - Грузовой
          0 - Выход'

      type = gets.to_i

      break if type.zero?
      case type
      when type == 1
        PassengerCar.new
      when type == 2
        CargoCar.new
      else
        puts 'Выберите тип вагона'
      end
    end
  end

  def train_move_next
    train = choose_train

    train.move_next
  end

  def train_move_back
    train = choose_train

    train.move_back
  end

  def show_list_of_stations
    @stations.each { |station| puts station.name }
  end

  def show_list_of_trains_on_station
    station = choose_station
    puts station.trains
  end
end

Main.new.start
