class Car
  include CompanyAccessor
  include Validator

  attr_reader :type
  attr_accessor :volume, :take_volume

  TYPE_FORMAT = /^(cargo|passenger)$/i

  def initialize(type, volume)
    @type = type
    @volume = volume
    @take_volume = 0

    validate!
  end

  protected

  def validate!
    raise 'Не правильный тип вагона' if type !~ TYPE_FORMAT
  end
end
