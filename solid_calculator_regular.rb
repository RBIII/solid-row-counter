STRING = "0111111111111111111011111111101111111111111111111111111110111111011111111011111001111001110111111110011111111111111111111111111111111111101101111111101101111111101111111111111011111011101111111111111111111111111111111101111101111111111101111111111111111111111111111111111111111101111111101111111111111101011111111111111011111111111111111011101111011111111110111111101111111111111111001111111111111111111011110011101111111010111110111111111111101111011111111111111111110111101111111111111111010101111111011011101111111110111111111111111111011101111111111111011111011011111111110111101111111111111111110011111111111111111111101101111111111111111111011100111111111111101101101111111111111111111111111110111101110111011111011111101111111110111110110111111111111111111111011111111101111111111011111111101101111111111111111111111111111111111101111111111111101111111011011110111111111111111110111111111111111111111011111111111111101110110110101111101101111111111111111011111111111111111110111111011111111011"

board_size(STRING)


def board_size(string)
  factors = compute_factors(string)
  rows_index = 0
  columns_index = -1
  solid_rows = {}
  solid_columns = {}

  while rows_index < (factors.length.to_f / 2)
    # create board based on the length of the string and its factors
    board = create_board(string, factors[rows_index], factors[columns_index])
    board_size = "#{factors[rows_index]}x#{factors[(columns_index)]}"

    # count the solid rows & columns in the current_board
    solid_row_count = count_solid_rows(board)
    solid_column_count = count_solid_columns(board)

    # add the solid counts of each to their respective hashes & modify indexes
    solid_rows[board_size] = solid_row_count
    solid_columns[board_size] = solid_column_count
    rows_index += 1
    columns_index -= 1
  end

  solid_rows.each do |board_dimentions, solid_count|
    if solid_count == solid_rows.values.max
      puts "The board formation that contains the most"
      puts "solid rows is #{board_dimentions} with #{solid_count} solid rows"
      puts ""
    end
  end

  solid_columns.each do |board_dimentions, solid_count|
    if solid_count == solid_columns.values.max
      puts "The board formation that contains the most"
      puts "solid columns is #{board_dimentions} with #{solid_count} solid columns"
      puts ""
    end
  end
end

def compute_factors(string)
  factors = []
  n = 2
  string_length = string.length
  while n < string_length
    if string_length % n == 0
      factors << n
    end
    n += 1
  end
  factors
end

def create_board(input_string, rows, columns)
  board = []
  row_start = 0
  row_end = columns - 1
  rows.times do
    row = input_string.slice(row_start..row_end).chars
    board << row
    row_start += columns
    row_end += columns
  end
  board
end

def count_solid_rows(board)
  solid_rows = 0
  board.each do |row|
    if row.all? {|element| element == "1"}
      solid_rows += 1
    end
  end
  solid_rows
end

def count_solid_columns(board)
  solid_columns = 0
  index = 0
  row_length = board.first.length
  until index == row_length
    if board.all? {|row| row[index] == "1"}
      solid_columns += 1
    end
    index += 1
  end
  solid_columns
end
