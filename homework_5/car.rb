class Car
  include CompanyAccessor

  attr_reader :type

  def initialize(type)
    @type = type
  end
end
