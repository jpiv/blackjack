class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <%= button %>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <span class="endGame"><%= outcome %></span>
  '

  el: "<><div id='main'></div>"
  attributes: {
                button: ""
                outcome: ""
              }

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': ->
      @model.get('dealerHand').stand()
      @model.get('playerHand').stand()
      @model.checkWin()
    'click .playAgain': -> @model.reset()


  initialize: ->
    @model.on 'reset', @render, @
    @model.on 'gameOver', (outcome)=> @render outcome, @
    @model.on 'playerBust', (outcome)=> @render outcome, @
    @render()

  render: (outcome)->
    outcome = outcome or ""
    @attributes.outcome = outcome
    if outcome isnt ""
      @attributes.button = '<button class="playAgain">Play Again.</button>'
    else
      @attributes.button = ''
    @$el.children().detach()
    @$el.html @template @attributes
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el



      # (@$el.find '.endGame').html @checkWin()
      # @button.button = '<button class="playAgain">Play Again.</button>'
      # @$el.html @template @button
