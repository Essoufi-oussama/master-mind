class Computer
  attr_accessor :selected_colors

  def initialize
      @selected_colors = Array.new
  end

  def select_color_4_times(array_colors)
      4.times do
         @selected_colors << array_colors.sample
      end
  end
end
