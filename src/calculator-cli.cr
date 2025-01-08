require "big"

# Calculator module that provides command-line interface and calculation functionality
module Calculator::Cli
  VERSION = "0.2.0"

  # Advanced calculator implementation with support for arithmetic operations,
  # operator precedence, and VI-style navigation
  class AdvancedCalculator
    # Define operator precedence levels
    PRECEDENCE = {
      "+" => 1,
      "-" => 1,
      "*" => 2,
      "/" => 2,
      "^" => 3
    }

    # History management for VI-style navigation
    class History
      property commands : Array(String)
      property position : Int32

      def initialize
        @commands = [] of String
        @position = -1
      end

      def add(command : String)
        @commands << command unless command.strip.empty?
        @position = @commands.size
      end

      def previous
        return nil if @commands.empty? || @position <= 0
        @position -= 1
        @commands[@position]?
      end

      def next
        return nil if @commands.empty? || @position >= @commands.size - 1
        @position += 1
        @commands[@position]?
      end

      def reset_position
        @position = @commands.size
      end
    end

    # Calculator state management
    class State
      property input : String
      property insert_mode : Bool
      property history : History

      def initialize
        @input = ""
        @insert_mode = true
        @history = History.new
      end
    end

    # Tokenize input expression into individual components
    def self.tokenize(expression : String)
      clean_expr = expression.gsub(/\s+/, " ").strip
      tokens = [] of String
      current_number = ""
      
      clean_expr.each_char do |char|
        case char
        when '0'..'9', '.'
          current_number += char
        else
          if !current_number.empty?
            tokens << current_number
            current_number = ""
          end
          tokens << char.to_s unless char.whitespace?
        end
      end
      
      tokens << current_number unless current_number.empty?
      tokens
    end

    # Convert infix notation to postfix notation using Shunting Yard algorithm
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
          operator_stack.pop if !operator_stack.empty?
        elsif PRECEDENCE.has_key?(token)
          while !operator_stack.empty? && 
                operator_stack.last != "(" && 
                PRECEDENCE[operator_stack.last]? && 
                PRECEDENCE[operator_stack.last] >= PRECEDENCE[token]
            output_queue << operator_stack.pop
          end
          operator_stack << token
        end
      end

      while !operator_stack.empty?
        output_queue << operator_stack.pop
      end

      output_queue
    end

    # Evaluate postfix expression and return result
    def self.evaluate_postfix(postfix_tokens)
      stack = [] of Float64

      postfix_tokens.each do |token|
        if token =~ /^-?\d+\.?\d*$/
          stack << token.to_f
        else
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

    # Calculate result for given expression
    def self.calculate(expression : String)
      return 0.0 if expression.strip.empty?
      tokens = tokenize(expression)
      postfix_tokens = infix_to_postfix(tokens)
      evaluate_postfix(postfix_tokens)
    end

    # Process a key press and update state
    private def self.process_keypress(key : String, state : State)
      case key
      when "\e"  # ESC
        state.insert_mode = false
        return false
      when "i"
        state.insert_mode = true if !state.insert_mode
        return false
      when "k"
        if !state.insert_mode
          if prev = state.history.previous
            state.input = prev
          end
        end
        return false
      when "j"
        if !state.insert_mode
          if next_cmd = state.history.next
            state.input = next_cmd
          end
        end
        return false
      when "\r", "\n"
        puts
        if state.input.strip == ":q"
          return true
        end
        
        begin
          unless state.input.strip.empty?
            result = calculate(state.input)
            puts "#{state.input} = #{result}"
            state.history.add(state.input)
            state.input = ""
          end
        rescue ex
          puts "Error: #{ex.message}"
        end
        
        state.insert_mode = true
        return false
      when "\u{7F}", "\b"  # Backspace
        if state.insert_mode && !state.input.empty?
          state.input = state.input[0...-1]
        end
        return false
      else
        if state.insert_mode
          state.input += key
        end
        return false
      end
    end

    # Main run loop with VI-style navigation
    def self.run
      state = State.new

      puts "Advanced Crystal Calculator with VI Navigation"
      puts "Available commands:"
      puts "  ESC    - Enter normal mode"
      puts "  i      - Enter insert mode"
      puts "  k      - Previous command (in normal mode)"
      puts "  j      - Next command (in normal mode)"
      puts "  :q     - Quit calculator"
      puts "Start typing expressions (e.g., 2 + 2, 3 * 4)"

      system("stty raw -echo")  # Enable raw mode

      loop do
        print "\r\u001b[K> #{state.input}"  # Clear line and show prompt
        
        if char = STDIN.raw(&.read_char)
          break if process_keypress(char.to_s, state)
        end
      end

    ensure
      system("stty -raw echo")  # Restore terminal settings
      #puts "\nCalculator closed. Goodbye!"
    end
  end
end

# Run the calculator
Calculator::Cli::AdvancedCalculator.run
