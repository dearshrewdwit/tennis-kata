class Game
  ROLES = %i(server returner)
  SCORES = ['0', '15', '30', '40']
  DEUCE_SCORES = ['40', 'ad']
  MIN_PTS_TO_WIN = 4
  WIN_BY_AMOUNT = 2

  def initialize
    @points = []
  end

  def point_won_by(player_role)
    @points << player_role
  end

  def score
    server_pts = @points.count(:server)
    returner_pts = @points.count(:returner)

    current_max_pts = [server_pts, returner_pts].max

    return "game won by #{points_leader}" if game_won?(server_pts, returner_pts, current_max_pts)

    score_for_both(server_pts, returner_pts)
  end

  private

  def points_leader
    @points.max_by { |role| @points.count(role) }
  end

  def game_won?(server_points, returner_points, current_max_pts)
    current_max_pts >= MIN_PTS_TO_WIN && (server_points - returner_points).abs >= WIN_BY_AMOUNT
  end

  def score_for_both(server_points, returner_points)
    if deuce_game?(server_points, returner_points)
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

  def deuce_game?(server_points, returner_points)
    server_points + returner_points >= 6
  end
end
