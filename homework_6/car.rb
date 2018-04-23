class Car
  include CompanyAccessor

  attr_reader :type

  TYPE_FORMAT = /^(cargo|passenger)$/i

  def initialize(type)
    @type = type

    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise 'Не правильный тип вагона' if type !~ TYPE_FORMAT
    true
  end
end
