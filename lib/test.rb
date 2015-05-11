require_relative 'factory'

=begin
puts Customer = Factory::Factory.new(:name, :address, :zip)
#=> Customer
 
puts joe = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
#=> #<struct Customer name="Joe Smith", address="123 Maple, Anytown NC", zip=12345>
 
puts joe.name
puts joe["name"]
puts joe[:name]
puts joe[0]
#=> "Joe Smith"

Customer1 = Factory::Factory.new(:name, :address) do
  public
  def greeting
    "Hello #{name}!"
  end
end

puts Customer1.new("Dave", "123 Main").greeting
#=> "Hello Dave!"


Factory::Factory.new('Ca', :name, :address)

Customer = Factory::Factory.new(:name, :address, :zip)
joe   = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
joejr = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
jane  = Customer.new("Jane Doe", "456 Elm, Anytown NC", 12345)
puts joe == joejr   #=> true
puts joe == jane    #=> false

Customer = Factory::Factory.new(:name, :address, :zip)
joe = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)

joe["name"] = "Luke"
joe[:zip]   = "90210"

puts joe.name   #=> "Luke"
puts joe.zip    #=> "90210"

Customer = Factory::Factory.new(:name, :address, :zip)
joe = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
joe.each {|x| puts(x) }

Customer = Factory::Factory.new(:name, :address, :zip)
joe = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
joe.each_pair {|name, value| puts("#{name} => #{value}") }
puts joe.length   #=> 3

print joe.members #=> [:name, :address, :zip]

Lots = Factory::Factory.new(:a, :b, :c, :d, :e, :f)
l = Lots.new(11, 22, 33, 44, 55, 66)
print l.select {|v| (v % 2).zero? }   #=> [22, 44, 66]

print l.to_a
print l.to_h

=begin
=end