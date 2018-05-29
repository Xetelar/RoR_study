module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      attr_history = "@#{name}_history".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        arr_values = instance_variable_get(attr_history) || []
        instance_variable_set(attr_history, arr_values << instance_variable_get(var_name))
        instance_variable_set(var_name, value)
      end
      define_method("#{name}_history".to_sym) do
        instance_variable_get(attr_history)
      end
    end
  end

  def strong_attr_accessor(name, class_name)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }

    define_method("#{name}=".to_sym) do |value|
      raise 'Неправильный класс' unless value.instance_of? class_name
      instance_variable_set(var_name, value)
    end
  end
end

class Test
  extend Accessors

  attr_accessor_with_history :a
  strong_attr_accessor :b, 'string'
end
