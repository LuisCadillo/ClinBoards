require_relative 'store'
require 'terminal-table'

class ClinBoards
  def initialize
    @store = Store.new('store.json')
  end

  def start
    display_welcome
    print_table(title: 'CLIn Boards',
                headings: %w[ID Name Description List(#cards)],
                rows: @store.boards)
    action = ''
    until action == 'exit' 
      action, id = menu('Board', ['create', 'show ID', 'update ID', 'delete ID' ])
      case action
      when "create"
        puts 'create in progress'
      when 'show'
        puts 'show in progress'
      when 'update'
        puts 'update in progress'
      when 'delete'
        puts 'delete in progress'
      end
    end
    display_goodbye
  end

  private
  def display_welcome
    puts "Welcome to CLIn Boards".center(90, '-')
  end

  def print_table(title:, headings:, rows:)
    table = Terminal::Table.new
    table.title = title
    table.headings = headings
    table.rows = rows.map(&:details)
    puts table
  end

  def menu(name, options)
    puts "#{name} options: #{options.join(' | ')}"
    puts 'exit'
    print '> '
    action, id = gets.chomp.split
    [action, id.to_i]
  end

  def display_goodbye
    puts 'Thanks for using CLIn Boards'.center(90, '-')
  end
end

app = ClinBoards.new
app.start