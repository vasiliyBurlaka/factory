require_relative "factory/version"

module Factory
  # Your code goes here...
  class Factory
    def self.new(*class_fields, &block)
      raise 'Wrong param count' if class_fields.count < 1
      class_name = false
      if class_fields[0].class == String
        class_name = class_fields.shift
      end

      res_class = Class.new do
        define_method :initialize do |*instants_fields|
          class_fields.each_with_index { |elem, index|
            instance_variable_set("@#{elem}", instants_fields[index])
          }
        end

        class_fields.each { |field|
          define_method field do
            instance_variable_get("@#{field}")
          end
        }        

        #Как объеденить эти 2 метода?
        define_method :[] do |field|
          case field
            when String, Symbol
              instance_variable_get("@#{field}")
            when Fixnum
              var_name = instance_variables[field]
              instance_variable_get(var_name)
            else
              raise TypeError, 'Wrong type of index'
          end
        end

        define_method :[]= do |field, val|
          case field
            when String, Symbol
              instance_variable_set("@#{field}", val)
            when Fixnum
              var_name = instance_variables[field]
              instance_variable_set(var_name, val)
            else
              raise TypeError, 'Wrong type of index'
          end
        end

        define_method :== do |other_inst|
          if self.class == other_inst.class 
            result = true
            instance_variables.each { |instance_var|
              result = false unless instance_variable_get(instance_var) == other_inst.instance_variable_get(instance_var)
            }
          else 
            result = false
          end

          result  
        end

        define_method :each do |&block|
          instance_variables.each { |var_name|
            block.call(instance_variable_get(var_name))
          }
        end

        define_method :each_pair do |&block|
          instance_variables.each { |var_name|
            block.call(var_name[1..-1], instance_variable_get(var_name))
          }
        end

        define_method :length do
          instance_variables.count
        end

        define_method :members do
          instance_variables.inject(Array.new()) { |res, elem|
            res << elem[1..-1].to_sym
          }
        end

        define_method :select do |&block|
          instance_variables.inject(Array.new()) { |res, var_name|
            var_value = instance_variable_get(var_name)
            res << var_value if block.call(var_value)
            res
          }
        end

        define_method :to_a do
          instance_variables.inject(Array.new()) { |res, elem|
            res << instance_variable_get(elem)
            res
          }
        end

        define_method :to_h do
          instance_variables.inject(Hash.new()) { |res, elem|
            res[elem[1..-1]] = instance_variable_get(elem)
            res
          }
        end        

        class_eval &block if block_given?

      end

      const_set(class_name, res_class) if class_name

      res_class
    end
  end

end