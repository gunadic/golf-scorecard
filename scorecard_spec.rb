require 'rspec'
require_relative 'scorecard'

describe HoleLayout do
  it 'checks if the file course.csv exists in the directory' do
    tester = HoleLayout.new
    expect(tester.check_for_file).to eql(true)
  end

  it 'loads the course layout from course.csv' do
    tester = HoleLayout.new
    holder = tester.load_course
    expect(holder.length).to_not eql(0)
  end

  it 'can check if the course is valid' do
    tester = HoleLayout.new
    tester.load_course
    expect(tester.is_course_valid?).to eql(true)
  end


end