
class Player
  LETTER_MAP = {
    'a' => 0,
    'b' => 1,
    'c' => 2,
    'd' => 3,
    'e' => 4,
    'f' => 5,
    'g' => 6,
    'h' => 7
  }

  NUMBER_MAP = {
    '1' => 0,
    '2' => 1,
    '3' => 2,
    '4' => 3,
    '5' => 4,
    '6' => 5,
    '7' => 6,
    '8' => 7
  }

  attr_reader :name
  attr_accessor :color
  def initialize(name)
    @name = name
  end

  def get_start_pos
    ask_for_input('Enter the position of the piece you want to move, e.g. "2,2"')
  end

  def get_end_pos
    ask_for_input('Enter the destination position, e.g. "2,2"')
  end

  private
  def ask_for_input(message)
    begin
      puts message.colorize(color)
      input = gets.chomp
      raise InputLengthError.new if input.length != 2
      input = input.split('')
      raise InputContentError.new if LETTER_MAP[input.first].nil? || NUMBER_MAP[input.last].nil?
    rescue InputLengthError
      puts "Invalid length!"
      retry
    rescue InputContentError
      puts "Invalid content!"
      retry
    end

    [ NUMBER_MAP[input.last], LETTER_MAP[input.first] ]
  end

end
