# calc.cr

puts "Enter the first number:"
input = gets
if input.nil?
  puts "No input detected. Exiting..."
  exit(1)
end
num1 = input.chomp.to_f

puts "Enter the second number:"
input = gets
if input.nil?
  puts "No input detected. Exiting..."
  exit(1)
end
num2 = input.chomp.to_f

puts "Choose an operation (+, -, *, /):"
input = gets
if input.nil?
  puts "No input detected. Exiting..."
  exit(1)
end
op = input.chomp

result = case op
when "+"
  num1 + num2
when "-"
  num1 - num2
when "*"
  num1 * num2
when "/"
  if num2 == 0.0
    puts "Error: Division by zero is not allowed."
    exit(1)
  end
  num1 / num2
else
  puts "Invalid operator. Please use one of the following: +, -, *, /"
  exit(1)
end

puts "#{num1} #{op} #{num2} = #{result}"
