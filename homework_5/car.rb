class Car
  attr_reader :type

  include CompanyAccessor

  def initialize(type)
    @type = type
  end
end
