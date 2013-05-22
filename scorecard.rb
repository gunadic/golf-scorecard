require 'csv'

class HoleLayout
  @course = []
  def load_course
    if check_for_file
      temparray = CSV.read('course.csv')[0,1]
      @course = temparray.flatten!
      @course.map! {|x| x.to_i}
    else
      puts "Could not find course.csv"
    end
    @course
  end

  def check_for_file
    FileTest.exists?('course.csv')
  end

  def is_course_valid?
    sum = @course.inject(:+)
    if sum == 72
      true
    else
      false
    end
  end

end