Show = null

describe 'Show', ->

	it 'can set and get its properties', ->
		Show = require '../scraper/coffee/models/show.coffee'

		newGirl = new Show('New Girl', 'new_girl.html')
		expect(newGirl.name).toEqual 'New Girl'
		expect(newGirl.url).toEqual 'new_girl.html'
		expect(newGirl.seasons.length).toEqual 0

		seasons =
			1: 'first season'
			2: 'second season'

		for num, season of seasons
			newGirl.setSeason(num, season)

		expect(newGirl.seasons.length).toEqual 2
		expect(newGirl.getSeason(2)).toEqual 'second season'

		newGirl.setSeason(2, 'more second season')
		expect(newGirl.getSeason(2)).toEqual(
			'more second season'
		)
		expect(newGirl.seasons.length).toEqual 2

		newGirl.setSeason(3, 'third season')
		expect(newGirl.seasons.length).toEqual 3

		newGirl.clearSeasons()
		expect(newGirl.seasons.length).toEqual 0
