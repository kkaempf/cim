class Qualifier
  @@modes = [ :key, :in, :out, :write, :propagated ]
  
  def initialize mode = 0
    @mode = 0;
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
    @mode & 1
  end
  
  def in?
    @mode & 2
  end
  
  def out?
    @mode & 4
  end
  
  def write?
    @mode & 8
  end
  
  def propagated?
    @mode & 16
  end

end