require 'rspec'
require 'pry'
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
  let(:ex_score) {ScoreCard.new(hole)}
  it "receives an array containing the course layout" do
    scores = ScoreCard.new(hole)
    expect(scores.course_score).to eql(hole)
  end

  it 'loads in players score file' do
    test_score = ScoreCard.new
    test_score.load_scores
    expect(test_score.scores.length).to_not eql(0)
  end

  it 'compares par to the golfers score' do
    ex_score.load_scores
    woods_score = ex_score.scores["Woods, Tiger"]
    expect(woods_score.length).to eql(ex_score.course_score.length)
  end

  it 'converts difference between score and par to golf terms' do
    ex_score.load_scores
    ex_score.convert
    woods_score = ex_score.wordified_scores[0]
    expect(woods_score[0].class).to eql(String)
  end

  it 'tabulates a golfer\'s total score' do
    ex_score.load_scores
    ex_score.total
    expect(ex_score.total_scores[0]).to eql(63)
  end

  it 'prints out the player\'s scorecard all pretty-like' do
    ex_score.load_scores
    ex_score.convert
    ex_score.total
    ex_score.output
    expect(ex_score.outputs[0].class).to eql(String)
  end

end