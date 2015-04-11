class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': ->
      @model.get('dealerHand').stand()
      @model.get('playerHand').stand()
      alert @checkWin()


  initialize: ->
    @model.on 'reset', @render, @
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  checkWin: ->
    if @model.get('playerHand').minScore < @model.get('dealerHand').minScore
      "YOU WIN!"
    else if @model.get('playerHand').minScore == @model.get('dealerHand').minScore
      "DRAW"
    else
      "YOU LOSE"

