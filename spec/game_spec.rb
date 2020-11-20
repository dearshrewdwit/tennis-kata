require 'game'

RSpec.describe(Game) do
  subject(:game) { described_class.new }

  describe '#score' do
    context 'server points' do
      it 'can score 15:0' do
        game.point_won_by(:server)
        expect(game.score).to eq "15:0"
      end

      it 'can score 30:0' do
        2.times { game.point_won_by(:server) }
        expect(game.score).to eq "30:0"
      end

      it 'can score 40:0' do
        3.times { game.point_won_by(:server) }
        expect(game.score).to eq "40:0"
      end

      it 'can score game won by server' do
        4.times { game.point_won_by(:server) }
        expect(game.score).to eq "game won by server"
      end
    end

    context 'returner points' do
      it 'can score 0:15' do
        game.point_won_by(:returner)
        expect(game.score).to eq "0:15"
      end

      it 'can score 0:30' do
        2.times { game.point_won_by(:returner) }
        expect(game.score).to eq "0:30"
      end

      it 'can score 0:40' do
        3.times { game.point_won_by(:returner) }
        expect(game.score).to eq "0:40"
      end

      it 'can score game won by returner' do
        4.times { game.point_won_by(:returner) }
        expect(game.score).to eq "game won by returner"
      end
    end

    context 'both returner and server points' do
      it 'can score 15:15' do
        game.point_won_by(:returner)
        game.point_won_by(:server)

        expect(game.score).to eq "15:15"
      end

      it 'can score 15:30' do
        2.times { game.point_won_by(:returner) }
        game.point_won_by(:server)

        expect(game.score).to eq "15:30"
      end

      it 'can score 30:15' do
        game.point_won_by(:returner)
        2.times { game.point_won_by(:server) }

        expect(game.score).to eq "30:15"
      end

      it 'can score 30:30' do
        2.times { game.point_won_by(:returner) }
        2.times { game.point_won_by(:server) }

        expect(game.score).to eq "30:30"
      end

      it 'can score 40:30' do
        2.times { game.point_won_by(:returner) }
        3.times { game.point_won_by(:server) }

        expect(game.score).to eq "40:30"
      end

      it 'can score 30:40' do
        3.times { game.point_won_by(:returner) }
        2.times { game.point_won_by(:server) }

        expect(game.score).to eq "30:40"
      end

      it 'can score 40:15' do
        game.point_won_by(:returner)
        3.times { game.point_won_by(:server) }

        expect(game.score).to eq "40:15"
      end

      it 'can score 15:40' do
        3.times { game.point_won_by(:returner) }
        game.point_won_by(:server)

        expect(game.score).to eq "15:40"
      end
    end

    context 'deuce' do
      before do
        3.times { game.point_won_by(:returner) }
        3.times { game.point_won_by(:server) }
      end

      it 'can score 40:40 - deuce' do
        expect(game.score).to eq "40:40"
      end

      context 'when next pt is ad server' do
        before { game.point_won_by(:server) }

        it 'can score ad:40 - ad server' do
          expect(game.score).to eq "ad:40"
        end

        it 'can score 40:40 - back to deuce after ad server' do
          game.point_won_by(:returner)

          expect(game.score).to eq "40:40"
        end

        it 'can score ad:40 - back to ad server after deuce' do
          game.point_won_by(:returner)
          game.point_won_by(:server)

          expect(game.score).to eq "ad:40"
        end

        it 'can score 40:ad - ad returner after ad server' do
          2.times { game.point_won_by(:returner) }

          expect(game.score).to eq "40:ad"
        end
      end

      it 'can score a win by 2 for server' do
        2.times { game.point_won_by(:server) }

        expect(game.score).to eq "game won by server"
      end

      it 'can score a win by 2 for returner' do
        game.point_won_by(:server)
        3.times { game.point_won_by(:returner) }

        expect(game.score).to eq "game won by returner"
      end
    end
  end
end
