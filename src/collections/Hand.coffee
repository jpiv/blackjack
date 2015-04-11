class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    @hasStood = false

  hit: ->
    if not (@hasStood)
      if @minScore() <= 21
        lastCard = @deck.pop()
        @add(lastCard)
        lastCard
      if @minScore() > 21
        @trigger 'bust', @
        null

  stand: ->
    if not (@hasStood)
      if @isDealer
        (@at 0).flip()
        while @minScore() < 17
          @hit()
      @hasStood = true



  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]


