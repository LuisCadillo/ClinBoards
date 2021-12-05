require 'json'
require_relative 'board'
require_relative 'list'
require_relative 'card'

class Store
  attr_accessor :boards, :lists, :parse_boards, :get_lists
  def initialize(json_file) 
    @json_file = json_file
    @boards = []
  end

  def generate_board_instances
    boards = parse_json
    Board.reset_crr_id
    @boards = boards.map do |board| # [board1, board2] array of Board instances
      List.reset_crr_id
      Board.new(board)
    end
  end

  def get_lists(board_id)
    board = find_board(board_id)
    @crr_board = board
    @crr_board.lists
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

  def create_list(name)
    @crr_board.lists << List.new(name)
    update_json
  end

  def update_list(new_name:, name:)
    found_list = find_list(name)
    found_list.name = new_name
    update_json
  end

  def delete_list(name)
    @crr_board.lists.delete_if {|list| list.name == name}
    update_json
  end

  def create_card(&options)
    card_id = calc_cards_q + 1
    list_name, new_data = options.call(card_id, @crr_board.lists.map(&:name))
    found_list = find_list(list_name)
    found_list.cards << Card.new(new_data)
    update_json
  end

  def update_card(id, new_data)
    card = find_card(id)
    pp card
    card.update(new_data)
    update_json
  end

  def delete_card(id)
    @crr_board.lists.each do |list|
      list.cards.delete_if {|card| card.id == id}
    end
    update_json
  end

  def add_task

  end

  def show_task

  end

  def toggle_task

  end

  def delete_task

  end

  def reset_cards_crr_id
    Card.reset_crr_id
  end

  def reorder_cards
    cards = @crr_board.lists.map(&:cards).flatten
    cards.each.with_index { |card, id| card.id = id + 1 }
  end

  private
  def parse_json
    JSON.parse(File.read(@json_file), symbolize_names: true)
  end

  def find_board(board_id)
    @boards.find { |board| board.id == board_id }
  end

  def find_list(name)
    @crr_board.lists.find {|list| list.name == name}
  end

  def find_card(id)
    card = @crr_board.lists.map do |list|
      list.cards.find {|card| card.id == id}
    end
    return card.compact.first
  end

  def calc_cards_q 
    cards_q = 0
    @crr_board.lists.each do |list|
      cards_q += list.cards.size
    end
    return cards_q
  end

  def update_json
    File.write(@json_file, @boards.to_json)
  end
end
