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

  # Все методы вынес protected чтобы пользователь не мог менять менять параметры напрямую, не используя меню

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
    puts 'Введите название маршрута'
    name = gets.chomp

    if @routes.find { |route| route.name == name }
      puts 'Маршрут уже существует'
    else
      start_station = choose_station
      finish_station = choose_station

      route = Route.new(start_station, finish_station, name)
      @routes << route

      route
    end
  end

  def choose_station
    return create_station if @stations.length.zero?

    loop do
      print 'Выберите станцию:'
      station_name = gets.chomp

      station = @stations.find { |el| el.name == station_name }
      return station if station

      puts 'Станции не существует'
    end
  end

  def choose_route
    return create_route if @routes.length.zero?

    loop do
      print 'Выберите маршрут:'
      route_name = gets.chomp

      route = @routes.find { |el| el.name == route_name }
      return route if route

      puts 'Маршрута не существует'
    end
  end

  def choose_train
    return create_train if trains.length.zero?

    loop do
      print 'Выберите поезд:'
      train_number = gets.chomp

      train = @trains.find { |el| el.number == train_number }
      return train if train

      puts 'Поезда не существует'
    end
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

    train.remove_car
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
