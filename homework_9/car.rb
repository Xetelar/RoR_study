class Car
  extend Acessors

  include CompanyAccessor
  include Validation

  attr_reader :type
  attr_accessor_with_history :volume, :taken

  TYPE_FORMAT = /^(cargo|passenger)$/i

  def initialize(type, volume)
    @type = type
    @volume = volume
    @taken = 0
    validate!
  end

  validate(:type, :format, TYPE_FORMAT)

  def free_volume
    @volume - @taken
  end

  def add_volume(value = 1)
    new_taken = @taken += value
    @taken = new_taken < @volume ? @volume : new_taken
  end

  protected

  def validate!
    raise 'Не правильный тип вагона' if type !~ TYPE_FORMAT
  end
end
