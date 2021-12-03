require 'json'
require_relative 'board'
class Store
  attr_accessor :boards
  def initialize(json_file) 
    @boards = create_boards(json_file) # [board1, board2] array of Board instances
  end

  def create_boards(json_file)
    boards = parse_json(json_file)
    boards.map do |board|
      Board.new(board)
    end
  end

  def update_board(board_id, new_data)
    # incomplete
    board = find_board(board_id)
    board.update(new_data)
    update_json
  end

  def delete_board

  end

  def create_list

  end

  def update_list

  end

  def delete_list

  end

  def create_card

  end

  def update_card

  end

  def delete_card

  end

  def add_task

  end

  def show_task

  end

  def toggle_task

  end

  def delete_task

  end

  private
  def parse_json(json_file)
    JSON.parse(File.read(json_file), symbolize_names: true)
  end

  def find_board(board_id)
    @boards.find { |board| board.id == board_id }
  end

  def update_json(json_file)
    JSON.write(File.read(json_file), @boards)
  end
end
