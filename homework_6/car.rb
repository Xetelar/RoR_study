class Car
  include CompanyAccessor
  include Validator

  attr_reader :type

  TYPE_FORMAT = /^(cargo|passenger)$/i

  def initialize(type)
    @type = type

    validate!
  end

  protected

  def validate!
    raise 'Не правильный тип вагона' if type !~ TYPE_FORMAT
  end
end
