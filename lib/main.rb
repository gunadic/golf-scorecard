load 'lib/course.rb'

def main
  augusta_national = HoleLayout.new
  augusta_national.load_course
  scores = ScoreCard.new(augusta_national.course)
  scores.load_scores
  scores.convert
  scores.total
  scores.output
  puts scores.outputs
  puts "\nLeaderboard:"
  puts scores.leaderboard
end

main