class Card
  attr_accessor :suite, :name, :value

  def initialize(suite, name, value)
    @suite, @name, @value = suite, name, value
  end
end

class Deck
  attr_accessor :playable_cards
  SUITES = [:hearts, :diamonds, :spades, :clubs]
  NAME_VALUES = {
    :two   => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 10,
    :queen => 10,
    :king  => 10,
    :ace   => [11, 1]}

  def initialize
    shuffle
  end

  def deal_card
    random = rand(@playable_cards.size)
    @playable_cards.delete_at(random)
  end

  def shuffle
    @playable_cards = []
    SUITES.each do |suite|
      NAME_VALUES.each do |name, value|
        @playable_cards << Card.new(suite, name, value)
      end
    end
  end
end

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def total
    @cards.map{|card| card[:value]}.reduce(:+)
  end
end

class Player
  attr_accessor :hand

  def initialize
    @hand = Hand.new
  end

  def bust
    if self.hand.total > 21
      true
    end
  end

  def blackjack
    if self.hand.total == 21
      true
    end
  end
end

class Dealer
  attr_accessor :hand

  def initialize
    @hand = Hand.new
  end
end

require 'test/unit'

class CardTest < Test::Unit::TestCase
  def setup
    @card = Card.new(:hearts, :ten, 10)
  end
  
  def test_card_suite_is_correct
    assert_equal @card.suite, :hearts
  end

  def test_card_name_is_correct
    assert_equal @card.name, :ten
  end
  def test_card_value_is_correct
    assert_equal @card.value, 10
  end
end

class DeckTest < Test::Unit::TestCase
  def setup
    @deck = Deck.new
  end
  
  def test_new_deck_has_52_playable_cards
    assert_equal @deck.playable_cards.size, 52
  end
  
  def test_dealt_card_should_not_be_included_in_playable_cards
    card = @deck.deal_card
    #given that deal_card returns the card that was dealt, this test should assert that the playable cards does NOT contain the card. "!" added to test.
    assert(!@deck.playable_cards.include?(card))
  end

  def test_shuffled_deck_has_52_playable_cards
    @deck.shuffle
    assert_equal @deck.playable_cards.size, 52
  end
end

class HandTest < Test::Unit::TestCase
  def setup
    @deck = Deck.new
    @hand = Hand.new
  end

  def test_initial_hand_has_two_cards
    2.times do
      @hand.cards << @deck.deal_card
    end
    assert_equal @hand.cards.length, 2
  end
end

class PlayerTest < Test::Unit::TestCase
  def setup
    @player = Player.new
    @deck = Deck.new
  end

  def test_player_initial_hand_has_two_cards
    2.times do
      @player.hand.cards << @deck.deal_card
    end
    assert_equal @player.hand.cards.length, 2
  end
end

class DealerTest < Test::Unit::TestCase
  def setup
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def test_dealer_initial_hand_has_two_cards
    2.times do
      @dealer.hand.cards << @deck.deal_card
    end
    assert_equal @dealer.hand.cards.length, 2
  end
end