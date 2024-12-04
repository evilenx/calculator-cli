# TODO: Write documentation for `Calculator::Cli`
module Calculator::Cli
  VERSION = "0.2.0"

  # TODO: Put your code here
end

require "big"

class AdvancedCalculator
  # Define operator precedence
  PRECEDENCE = {
    "+" => 1,
    "-" => 1,
    "*" => 2,
    "/" => 2,
    "^" => 3
  }

  def self.tokenize(expression : String)
    # Remove all whitespace
    clean_expr = expression.gsub(/\s+/, "")
    
    # Tokenize the expression
    tokens = [] of String
    current_token = ""
    
    clean_expr.each_char do |char|
      if char =~ /[0-9.]/
        current_token += char
      else
        tokens << current_token if !current_token.empty?
        current_token = ""
        tokens << char.to_s
      end
    end
    
    tokens << current_token if !current_token.empty?
    tokens
  end

  def self.infix_to_postfix(tokens)
    output_queue = [] of String
    operator_stack = [] of String

    tokens.each do |token|
      if token =~ /^-?\d+\.?\d*$/
        output_queue << token
      elsif token == "("
        operator_stack << token
      elsif token == ")"
        while !operator_stack.empty? && operator_stack.last != "("
          output_queue << operator_stack.pop
        end
        operator_stack.pop if !operator_stack.empty? # Remove the "("
      elsif PRECEDENCE.has_key?(token)
        while !operator_stack.empty? && 
              operator_stack.last != "(" && 
              PRECEDENCE[operator_stack.last] >= PRECEDENCE[token]
          output_queue << operator_stack.pop
        end
        operator_stack << token
      end
    end

    # Pop remaining operators
    while !operator_stack.empty?
      output_queue << operator_stack.pop
    end

    output_queue
  end

  def self.evaluate_postfix(postfix_tokens)
    stack = [] of Float64

    postfix_tokens.each do |token|
      if token =~ /^-?\d+\.?\d*$/
        stack << token.to_f
      else
        # Ensure we have enough operands
        raise ArgumentError.new("Invalid expression") if stack.size < 2

        b = stack.pop
        a = stack.pop

        result = case token
        when "+"
          a + b
        when "-"
          a - b
        when "*"
          a * b
        when "/"
          raise DivisionByZeroError.new("Division by zero") if b == 0
          a / b
        when "^"
          a ** b
        else
          raise ArgumentError.new("Unknown operator: #{token}")
        end

        stack << result
      end
    end

    raise ArgumentError.new("Invalid expression") if stack.size != 1
    stack.first
  end

  def self.calculate(expression : String)
    # Tokenize the expression
    tokens = tokenize(expression)

    # Convert to postfix notation
    postfix_tokens = infix_to_postfix(tokens)

    # Evaluate postfix expression
    result = evaluate_postfix(postfix_tokens)

    result
  end

  def self.run
    puts "Advanced Crystal Calculator"
    puts "Enter a mathematical expression (e.g., 2 + 4 - 10 / 2 * 2)"
    puts "Type 'exit' to quit"

    loop do
      print "> "
      
      # Read input
      input = gets
      
      # Exit if input is nil or 'exit'
      break if input.nil? || input.chomp.downcase == "exit"
      
      # Trim whitespace
      input = input.chomp
      
      begin
        # Calculate and display result
        result = calculate(input)
        puts "#{input} = #{result}"
      rescue ex
        puts "Error: #{ex.message}"
      end
    end

    puts "Calculator closed. Goodbye!"
  end
end

# Run the calculator
AdvancedCalculator.run



