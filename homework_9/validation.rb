module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :validation_types

    def validate(attr_name, validation_type, param = nil)
      @validation_types ||= []
      @validation_types << { attr_name: attr_name, type: validation_type, param: param }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validation_types.each do |type|
        attr_value = instance_variable_get("@#{type[:attr_name]}")
        send type[:type], attr_value, type[:param]
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def presence(name_value, *_opts)
      raise 'Имя/номер равно nil, или пустой строке' if name_value.to_s.empty?
    end

    def type(name_value, attr_type)
      raise 'Не совпадение класса объекта с заданным классом' unless name_value.is_a?(attr_type)
    end

    def format(name_value, format)
      raise 'Имя/номер не соответствует заданному формату' unless format.match?(name_value.to_s)
    end
  end
end
