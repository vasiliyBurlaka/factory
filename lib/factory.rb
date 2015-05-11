require "factory/version"

module Factory
  # Your code goes here...
  class Factory
    def self.new(*class_fields, &block)

      res_class = Class.new do
        define_method :initialize do |*instants_fields|
          class_fields.each_with_index { |elem, index|
            res_class.instance_variable_set("@#{elem}", instants_fields[index])
          }
        end

        class_fields.each { |field|
          define_method field do
            res_class.instance_variable_get("@#{field}")
          end
        }        

        define_method :[] do |field|
          case field
            when String, Symbol
              res_class.instance_variable_get("@#{field}")
            when Fixnum
              var_name = res_class.instance_variables[field]
              res_class.instance_variable_get(var_name)
            else
              raise TypeError, 'Wrong type of index'
          end
        end

        class_eval &block if block_given?

      end

      res_class
    end
  end

end