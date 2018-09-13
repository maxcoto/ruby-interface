module Interface
  class NotImplementedError < NoMethodError
  end

  def self.included(model)
    model.send(:extend,  Interface::ClassMethods)
    model.send(:extend,  Interface::Methods)
    model.send(:include, Interface::Methods)
  end

  module Methods
    def not_implemented(model_name, method_name)
      unless method_name
        caller.first.match(/in \`(.+)\'/)
        method_name = $1
      end

      error = "#{model_name} needs to implement #{method_name} for #{self.name}"
      raise Interface::NotImplementedError.new(error)
    end
  end

  module ClassMethods
    def needs_implementation(method, *args)
      model = self
      model.class_eval do
        define_method(method) do |*args|
          model.not_implemented(self.class.name, method)
        end
      end
    end
  end
end
