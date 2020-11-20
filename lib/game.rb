class Game
  ROLES = %i(server returner)
  SCORES = ['0', '15', '30', '40']
  DEUCE_SCORES = ['40', 'ad']
  DEUCE_RESULT = {
    0 => [0,0],
    1 => [1,0],
    -1 => [0,1],
  }
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

    return "game won by #{points_leader}" if game_won?(server_pts, returner_pts)

    format(*scores(server_pts, returner_pts))
  end

  private

  def points_leader
    @points.max_by { |role| @points.count(role) }
  end

  def game_won?(server_points, returner_points)
    current_max_pts = [server_points, returner_points].max
    current_max_pts >= MIN_PTS_TO_WIN && (server_points - returner_points).abs >= WIN_BY_AMOUNT
  end

  def scores(server_points, returner_points)
    if deuce_game?(server_points, returner_points)
      deuce_scores(server_points, returner_points)
    else
      game_scores(server_points, returner_points)
    end
  end

  def deuce_game?(server_points, returner_points)
    server_points + returner_points >= 6
  end

  def deuce_scores(server_points, returner_points)
    deuce_result = server_points - returner_points
    server_points, returner_points = DEUCE_RESULT[deuce_result]
    [DEUCE_SCORES[server_points], DEUCE_SCORES[returner_points]]
  end

  def game_scores(server_points, returner_points)
    [SCORES[server_points], SCORES[returner_points]]
  end

  def format(server_score, returner_score)
    "#{server_score}:#{returner_score}"
  end
end
