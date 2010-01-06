module CIM
class Qualifier
  MODES = [ :key, :in, :out, :write, :propagated ]
  
  # store mode as bitmask in single integer value
  def initialize *mode
    @mode = 0
    case mode
    when Array: mode.each { |m| self << m }
    when Symbol: self << mode
    end
  end
  
  def to_s
    i = 1
    s = ""
    MODES.each do |m|
      if (@mode & i) != 0
	s << "," unless s.empty?
	s << m.to_s
      end
      i <<= 1
    end
    s
  end

  def << mode
    case mode
    when :key
      @mode |= 1
    when :in
      @mode |= 2
    when :out
      @mode |= 4
    when :write
      @mode |= 8
    when :propagated
      @mode |= 16
    else
      raise "Invalid qualifier: #{mode}"
    end
  end
  
  def key?
    @mode & 1 != 0
  end
  
  def in?
    @mode & 2 != 0
  end
  
  def out?
    @mode & 4 != 0
  end
  
  def write?
    @mode & 8 != 0
  end
  
  def propagated?
    @mode & 16 != 0
  end

end
end
