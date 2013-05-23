require 'csv'

class HoleLayout
  attr_reader :course

  def initialize
      @course = []
  end

  def load_course
    if check_for_file
      temparray = CSV.read('course.csv')[0,1]
      @course = temparray.flatten!
      @course.map! {|x| x.to_i}
    else
      puts "Could not find course.csv"
    end
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

class ScoreCard
  attr_reader :course_score, :scores
  def initialize (course_score = nil)
    @course_score = course_score
    @scores = {}
  end

  def load_scores
    CSV.foreach('scores.csv') do |value|
      @scores["#{value[0]}, #{value[1]}"] = value[2..-1]
    end
  end

end