require 'csv'

class ScoreCard
  attr_reader :course_score, :scores, :wordified_scores, :total_scores, :outputs, :final_positions
  def initialize (course_score = nil)
    @course_score = course_score
    @scores = {}
    @wordified_scores = []
    @total_scores = []
    @final_positions = []
  end

  def load_scores
    CSV.foreach('scores.csv') do |value|
      @scores["#{value[0]}, #{value[1]}"] = value[2..-1]
    end
  end

  def wordify(score, course_score)
    case score.to_i - course_score.to_i
      when -2
        "Eagle"
      when -1
        "Birdie"
      when 0
        "Par"
      when 1
        "Bogey"
      when 2
        "Double Bogey"
      when 3
        "Triple Bogey"
      else
        ""
      end
  end

  def convert
    score_card_counter = 0
    counter = 0
    @scores.each do |key, value|
      @wordified_scores[score_card_counter] = []
      value.each do |score|
        if score.to_i == 1
          @wordified_scores[score_card_counter].push('Hole in One')
          counter += 1
        else
          @wordified_scores[score_card_counter].push(wordify(score,@course_score[counter % 18]))
          counter += 1
        end
      end
      score_card_counter += 1
    end
  end

  def total
    @scores.each do |key, value|
      total_score = 0
      value.each do |score|
        total_score += score.to_i
      end
      @total_scores << total_score
    end
  end

  def output
    @outputs = []
    counter = 0
    score_card_counter = 0
    hole = 1
    @scores.each do |player, scores|
      @outputs << player
      hole = 1
      counter = 0
      scores.each do
        @outputs[score_card_counter] += "\nHole #{(hole)}: #{scores[counter]} #{@wordified_scores[score_card_counter][counter]}"
        counter += 1
        hole += 1
      end
      @outputs[score_card_counter] += "\nTotal score: #{@total_scores[score_card_counter]}"
      @outputs[score_card_counter] += "\n#{@total_scores[score_card_counter].to_i - 72}\n"
      score_card_counter += 1
    end

  end

  def leaderboard
    counter = 0
    @total_scores.each do |score|
      @final_positions << "\n#{score.to_i-72} #{score} "
      counter+=1
    end
    counter = 0
    @scores.keys.each do |player|
      @final_positions[counter] += player
      counter+=1
    end
    @final_positions.sort.reverse!
    @final_positions
  end
end