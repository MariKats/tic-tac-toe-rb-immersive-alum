WIN_COMBINATIONS = [
  [0,1,2],[3,4,5],[6,7,8],
  [0,3,6],[1,4,7],[2,5,8],
  [0,4,8],[6,4,2]
]

def display_board(board)
  puts "\n"
  puts "       #{board[0]} | #{board[1]} | #{board[2]} "
  puts "      -----------"
  puts "       #{board[3]} | #{board[4]} | #{board[5]} "
  puts "      -----------"
  puts "       #{board[6]} | #{board[7]} | #{board[8]} "
  puts "\n"
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, value)
  board[index] = value
end

def valid_move?(board, index)
  index.between?(0,8) && board[index] == " "
end

def turn_count(board)
  board.count {|e| e != " "}
end

def current_player(board)
  count = turn_count(board)
  count % 2 == 0 ? "X" : "O"
end

def turn(board)
  print "Please enter 1-9: "
  input = gets.chomp
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    print "\nInvalid move. "
    turn(board)
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def won?(board)
  WIN_COMBINATIONS.find do |combo|
    combo.all? { |e| board[e] == "X" } || combo.all? { |e| board[e] == "O" }
  end
end

def full?(board)
  board.none? { |e| e == " " }
end

def over?(board)
  draw?(board) || won?(board)
end

def draw?(board)
  full?(board) && !won?(board)
end

def winner(board)
  if won?(board)
    first = won?(board)[0]
    board[first]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
  puts "\n"
end
