player1 = Player.create(name: "Player 1")
player2 = Player.create(name: "Player 2")

File.readlines("poker.txt").map{ |line| line.chomp }.each do |round|
  cards = round.split(" ")
  player1_hand = Hand.create(cards: cards[0..4].join(" "), player_id: 1)
  player2_hand = Hand.create(cards: cards[5..9].join(" "), player_id: 2)
  winner = (player1_hand <=> player2_hand)
  round = Round.create(winner_id: (winner == 1 ? 1 : 2))
  RoundHand.create(round_id: round.id, hand_id: player1_hand.id)
  RoundHand.create(round_id: round.id, hand_id: player2_hand.id)
end
