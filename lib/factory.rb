#require "factory/version"

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

        define_method :[] do |field|
          res_class.instance_variable_get("@#{field}")
          #вставь проверку классов!!!
        end

        define_method :to_s do |field|
          res_class.instance_variable_get("@#{field}")
        end


      end

      res_class
    end
  end

end


Customer = Factory::Factory.new(:name, :address, :zip)
#=> Customer

joe = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
#=> #<struct Customer name="Joe Smith", address="123 Maple, Anytown NC", zip=12345>

joe["name"]
joe[:name]
joe[0]
joe.name
#=> "Joe Smith"
=begin
=end