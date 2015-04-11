# TODO: Refactor this to use an internal Game instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    (@get 'playerHand').on 'bust', (-> @trigger 'playerBust', "YOU BUSTED"), @

  reset: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    (@get 'playerHand').on 'bust', (-> @trigger 'playerBust', "YOU BUSTED"), @
    @trigger 'reset'

  checkWin: ->
    if @get('playerHand').minScore() > 21
      outcome =  "YOU LOSE"
    else if @get('dealerHand').minScore() > 21
      outcome = "YOU WIN!"
    else if @get('playerHand').minScore() > @get('dealerHand').minScore()
      outcome = "YOU WIN!"
    else if @get('playerHand').minScore() == @get('dealerHand').minScore()
      outcome = "DRAW"
    else
      outcome = "YOU LOSE"

    @trigger "gameOver", outcome





