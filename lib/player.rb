class Player

  attr_accessor :selected_colors

  def initialize
  @selected_colors = Array.new
  end

  def select_color
      gets.chomp
  end

end
