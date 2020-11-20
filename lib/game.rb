class Game
  ROLES = %i(server returner)
  SCORES = ['0', '15', '30', '40']
  DEUCE_SCORES = ['40', 'ad']
  MIN_PTS_TO_WIN = 4
  WIN_BY_AMOUNT = 2

  def initialize()
    @points = []
  end

  def point_won_by(player_role)
    @points << player_role
  end

  def score
    server_points = @points.count(:server)
    returner_points = @points.count(:returner)
    
    current_max_role = @points.max_by { |role| @points.count(role) }
    current_max_pts = [server_points, returner_points].max

    if current_max_pts >= MIN_PTS_TO_WIN && (server_points - returner_points).abs >= WIN_BY_AMOUNT
      "game won by #{current_max_role}"
    else
      score_for_both(server_points, returner_points)
    end
  end

  private

  def score_for_both(server_points, returner_points)
    if server_points + returner_points >= 6
      if server_points == returner_points
        "#{DEUCE_SCORES[0]}:#{DEUCE_SCORES[0]}"
      elsif server_points > returner_points
        "#{DEUCE_SCORES[1]}:#{DEUCE_SCORES[0]}"
      else
        "#{DEUCE_SCORES[0]}:#{DEUCE_SCORES[1]}"
      end
    else
      "#{SCORES[server_points]}:#{SCORES[returner_points]}"
    end
  end
end
