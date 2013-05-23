require 'rspec'
require_relative '../lib/course'

describe HoleLayout do
  let(:tester) { HoleLayout.new }
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

describe ScoreCard do
  let(:hole) {HoleLayout.new.load_course}
  it "receives an array containing the course layout" do
    scores = ScoreCard.new(hole)
    expect(scores.course_score).to eql(hole)
  end

  it 'loads in players score file' do
    test_score = ScoreCard.new
    test_score.load_scores
    expect(test_score.scores.length).to_not eql(0)
  end
end