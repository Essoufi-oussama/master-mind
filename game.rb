require_relative 'lib/player'
require_relative 'lib/computer'

class Game
    attr_accessor :row, :player, :computer
    attr_reader :codemaker_colors, :colors_to_choose_from

    @@colors_to_choose_from = ["green", "yellow", "blue", "orange", "red", "white"]

    def initialize
        @player = Player.new
        @computer = Computer.new
        @win = ["red peg", "red peg", "red peg", "red peg"]
    end

    def start
        while true
            print "press 1 to start a new game 0 to exist "
            choice = gets.chomp
            case choice
            when '1'
                print "press 1 to be codebreaker or 2 to be codemaker "
                role = gets.chomp
                case role
                when '1'
                    self.play_as_codebreaker()
                when '2'
                    self.play_as_codemaker()
                else
                    print "you gave me #{choice} i dont know what to do with that"
                end
            when '0'
                break
            else
                print "you gave me #{choice} i dont know what to do with that"
            end
        end
    end


    def play_as_codebreaker

        select_color_4_times()
        computer_choice = self.computer.selected_colors
        12.times do
            # uncomment below if you want to cheat the computer
            # p computer_choice
            puts "colors to choose from are #{@@colors_to_choose_from} "
            player_colors_array = get_player_colors()
            player_colors_array
            feedback = give_feedback(player_colors_array, computer_choice)
            p feedback
            if feedback == @win
                puts "you guessed correctly! "
                return
            end
        end
        puts "you reached maximum amount of guessed. you lose! "
    end

    def play_as_codemaker
        player_choice = convert_colors_to_code(get_player_colors())
        computer_colors_array = ["1", "1", "2", "2"]
        possible_codes = generate_codes()
        feedback = give_feedback(computer_colors_array, player_choice)
        if feedback == @win
            puts "computer guessed correctly from first try "
            return
        end
        eliminate_codes( possible_codes, computer_colors_array, feedback)
        count = 1
        11.times do
            p possible_codes.first.split("")
            best_guess = possible_codes.first.split("")

            feedback = give_feedback(best_guess, player_choice)
            if feedback == @win
                puts "computer guessed after #{count} tries "
                return
            end
            eliminate_codes( possible_codes, best_guess, feedback)
            count += 1
        end

          puts "Computer reached the maximum number of guesses. It loses!"
    end

    private
    def select_color_4_times
        4.times do
           self.computer.selected_colors << @@colors_to_choose_from.sample
        end
    end

    def give_feedback(guess, choice)
        feedback = []
        guess.each_with_index do |color, index|
            if choice[index] == guess[index]
              feedback << "red peg"
            elsif guess.include?(color)
              feedback << "white peg"
            end
        end
        feedback
    end

    def convert_colors_to_code(colors)
        code = ''
        colors.each { |color| code += (@@colors_to_choose_from.find_index(color) + 1).to_s }
        code
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

    def generate_codes
        #create set of all the possible codes
        colors = (1..6).to_a
        all_combinations = []
        colors.each do |a|
            colors.each do |b|
                colors.each do |c|
                    colors.each do |d|
                        combination = "#{a}#{b}#{c}#{d}"
                        all_combinations << combination
                    end
                end
            end
        end
        all_combinations
    end

    def eliminate_codes(possible_codes, guess, feedback)
        possible_codes.reject! do |code|
            give_feedback(guess, code) != feedback
        end
    end

end

game = Game.new
game.start
