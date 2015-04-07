
class KevinPermutations
  def initialize(num_elems)
    @indices = (1..num_elems).to_a
    @speeds  = Array.new(num_elems) {|ii| ii == 0 ? 0 : -1}
  end

  def each
    return enum_for(:each) unless block_given?

    return if @indices.none?

    loop do
      yield @indices

      #puts "@indices = #{@indices.inspect}"
      #puts "@speeds  = #{@speeds.inspect}"

      score = @indices.zip(@speeds).map{|(ii,ss)| (ii*ss).abs }
      break if score.max == 0

      index_to_move = score.each_with_index.max[1]
      index_speed = @speeds[index_to_move]

      #puts "index_to_move: #{index_to_move}"
      #puts "index_speed:   #{index_speed}"

      idx1 = index_to_move
      idx2 = index_to_move + index_speed

      @indices[idx1], @indices[idx2] = @indices[idx2], @indices[idx1]
      @speeds[idx1],  @speeds[idx2]  = @speeds[idx2],  @speeds[idx1]

      #puts "@indices = #{@indices.inspect}"
      #puts "@speeds  = #{@speeds.inspect}"

      if (idx2 == 0) || (idx2 == @speeds.size-1) || (@indices[idx2+index_speed] > @indices[idx2])
        @speeds[idx2] = 0
      end

      #puts "@indices = #{@indices.inspect}"
      #puts "@speeds  = #{@speeds.inspect}"

      @speeds = @speeds.each_with_index.collect do |speed, ii|
        if (ii < idx2) && (@indices[ii] > @indices[idx2])
          +1
        elsif (ii > idx2) && (@indices[ii] > @indices[idx2])
          -1
        else
          speed
        end
      end

      # puts "@indices = #{@indices.inspect}"
      # puts "@speeds  = #{@speeds.inspect}"
    end

  end
end
