Collection = require "../../common/collection"
{logger} = require "../../common/logging"
FactorRange = require "../../range/factor_range"
CategoricalTicker = require "../../ticking/categorical_ticker"
CategoricalTickFormatter = require "../../ticking/categorical_tick_formatter"
Axis = require "./axis"

class CategoricalAxisView extends Axis.View

class CategoricalAxis extends Axis.Model
  default_view: CategoricalAxisView
  type: 'CategoricalAxis'

  initialize: (attrs, objects) ->
    super(attrs, objects)
    if not @get('ticker')?
      @set_obj('ticker', CategoricalTicker.Collection.create())
    if not @get('formatter')?
      @set_obj('formatter', CategoricalTickFormatter.Collection.create())

  _computed_bounds: () ->
    [range, cross_range] = @get('ranges')

    user_bounds = @get('bounds') ? 'auto'
    range_bounds = [range.get('min'), range.get('max')]

    if user_bounds != 'auto'
      logger.warn("Categorical Axes only support user_bounds='auto', ignoring")

    return range_bounds

class CategoricalAxes extends Collection
  model: CategoricalAxis

module.exports =
  Model: CategoricalAxis
  Collection: new CategoricalAxes()
  View: CategoricalAxisView
