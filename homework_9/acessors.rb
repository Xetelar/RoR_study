module Acessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_names = []
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        var_names << value
      end
      define_method("#{name}_history") { var_names }
    end
  end

  def strong_attr_acessor(name, class_name)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }

    define_method("#{name}=".to_sym) do |value|
      return instance_variable_set(var_name, value) if value.class.to_s.casecmp(class_name).zero?
      raise 'Неправильный класс'
    end
  end
end

class Test
  extend Acessors

  attr_accessor_with_history :a
  strong_attr_acessor :b, 'string'
end
