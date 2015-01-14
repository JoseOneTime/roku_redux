class Show
	constructor: (@name, @url) ->
		@desc = ''
		@clearSeasons()
		@timestamp = Date.now()

	getSeason: (seasonNum) -> @seasons[seasonNum]

	# TODO error-checking
	setSeason: (seasonNum, season) ->
		old = @seasons[seasonNum]
		@seasons[seasonNum] = season
		@seasons.length += 1 unless old?

	clearSeasons: -> @seasons = { length: 0 }

module.exports = Show
