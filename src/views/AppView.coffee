class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  el: "<div id='main'></div>"

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': ->
      @model.get('dealerHand').stand()
      @model.get('playerHand').stand()
      (@$el.find '.endGame').html @checkWin()


  initialize: ->
    @model.on 'reset', @render, @
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$el.append '<span class="endGame"></span>'

  checkWin: ->
    if @model.get('dealerHand').minScore() > 21
      "YOU WIN!"
    else if @model.get('playerHand').minScore() > @model.get('dealerHand').minScore()
      "YOU WIN!"
    else if @model.get('playerHand').minScore() == @model.get('dealerHand').minScore()
      "DRAW"
    else
      "YOU LOSE"

