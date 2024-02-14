require_relative 'lib/player'
require_relative 'lib/computer'

class Game
    attr_accessor :row, :player, :computer
    attr_reader :codemaker_colors, :colors_to_choose_from

    @@colors_to_choose_from = ["green", "yellow", "blue", "orange", "red", "white"]
    @@win = ["red peg", "red peg", "red peg", "red peg"]

    def initialize
        @player = Player.new
        @computer = Computer.new
    end

    def start
        while true
            print "press 1 to start a new game 0 to exist "
            choice = gets.chomp
            case choice
            when '1'
                self.play()
            when '0'
                break
            else
                print "you gave me #{choice} i dont know what to do with that"
            end
        end
    end


    def play

        select_color_4_times()
        12.times do
            # p self.computer.selected_colors uncomment if you want to cheat the computer
            puts "colors to choose from are #{@@colors_to_choose_from} "
            player_colors_array = get_player_colors()
            feedback = give_feedback(player_colors_array)
            p feedback
            if feedback == @@win
                puts "you guessed correctly! "
                break
            end

        end
    end

    private
    def select_color_4_times
        4.times do
           self.computer.selected_colors << @@colors_to_choose_from.sample
        end
    end

    def give_feedback(player_colors_array)
        feedback = []
        player_colors_array.each_with_index do |color, index|
            if self.computer.selected_colors[index] == player_colors_array[index]
              feedback << "red peg"
            elsif self.computer.selected_colors.include?(color)
              feedback << "white peg"
            end
        end
        feedback
    end

    def get_player_colors
        puts "| 1 | 2 | 3 | 4 |"
        puts "enter color accoridng to position sperated by spaces "
        player_color_choices = self.player.select_color
        player_color_array = player_color_choices.split(" ")
        if player_color_array.length != 4
            puts "Please enter exactly 4 colors."
            get_player_colors()
        end
        player_color_array.each do |color|
            if !@@colors_to_choose_from.include?(color)
                puts "Invalid color '#{color}'. Please choose from #{@@colors_to_choose_from}."
                return get_player_colors()
            end
        end
        player_color_array
    end

end

game = Game.new
game.start
