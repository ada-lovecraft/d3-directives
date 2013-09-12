directives = angular.module 'app.directives'
directives.directive 'd3Bars', ['$window','$timeout',($window,$timeout) ->
	restrict: 'EA'
	scope: 
		data: '='
	link: (scope, element, attrs) ->
		renderTimeout = null
		margin = parseInt attrs.margin || 20
		barHeight = parseInt attrs.barHeight || 20
		barPadding = parseInt attrs.barPadding || 5

		svg = d3.select(element[0])
			.append('svg')
			.style('width', '100%')

		$window.onresize = ->
			scope.$apply()

		
		scope.$watch('data', (newVal, oldVal) ->
			scope.render(newVal)
		, true)


		scope.$watch ->
			return angular.element($window)[0].innerWidth
		, -> 
			scope.render(scope.data)

		scope.render = (data) ->
			
			svg.selectAll('*').remove()

			return if !data
			if renderTimeout
				clearTimeout(renderTimeout)

			renderTimeout = $timeout ->
				width = d3.select(element[0])[0][0].offsetWidth - margin
				height = scope.data.length * (barHeight + barPadding)
				color = d3.scale.category20()
				xScale = d3.scale.linear()
					.domain([0, d3.max( data, (d) -> d.score ) ])
					.range([0, width])

				svg.attr('height', height)

				svg.selectAll('rect')
					.data(data)
					.enter()
						.append('rect')
						.on('click', (d,i) -> scope.onClick( {item: d } ) )
							
						.attr('height', barHeight)
						.attr('width', 140)
						.attr('x', Math.round(margin/2))
						.attr('y', (d,i) ->
							i * (barHeight + barPadding)
						).attr('fill', (d) ->
							color(d.score)
						).transition()
							.duration(1000)
							.attr('width', (d) ->
								xScale(d.score)
							)
	]
