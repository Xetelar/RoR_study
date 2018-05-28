module Accessors
  attr_reader :names

  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      names = []
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        names << var_name unless var_name.empty?
      end
      define_method("#{name}_history") { names }
    end
  end

  def strong_attr_accessor(name, class_name)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }

    define_method("#{name}=".to_sym) do |value|
      raise 'Неправильный класс' if value.instance_of? class_name
      instance_variable_set(var_name, value)
    end
  end
end

class Test
  extend Accessors

  attr_accessor_with_history :a
  strong_attr_accessor :b, 'string'
end
