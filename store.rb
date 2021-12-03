require 'json'
require_relative 'board'
class Store
  attr_accessor :boards, :show_boards
  def initialize(json_file) 
    @json_file = json_file
  end

  def show_boards
    boards = parse_json
    Board.reset_crr_id
    @boards = boards.map do |board| # [board1, board2] array of Board instances
      Board.new(board)
    end
  end

  def create_board(new_data)
    @boards << Board.new(new_data)
    update_json
  end

  def update_board(board_id, new_data)
    board = find_board(board_id)
    board.update(new_data)
    update_json
  end

  def delete_board(board_id)
    @boards.delete_if { |board| board.id == board_id }
    update_json
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
  def parse_json
    JSON.parse(File.read(@json_file), symbolize_names: true)
  end

  def find_board(board_id)
    @boards.find { |board| board.id == board_id }
  end

  def update_json
    File.write(@json_file, @boards.to_json)
  end
end
