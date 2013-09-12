directives = angular.module 'app.directives'
directives.directive 'aiPieChart', ['$window','$timeout',($window,$timeout) ->
	restrict: 'EA'
	scope: 
		data: '='
		chartColors: '='
	link: (scope, element, attrs) ->
		margin = parseInt attrs.margin || 20
		width = parseInt attrs.width || 300
		duration = parseInt attrs.duration || 1000
		height = width
		r = radius = width / 2

		color = d3.scale.category20()
		arc = d3.svg.arc()
				.outerRadius(r)

		tweenPie = (b) ->
			b.innerRadius = 0
			i = d3.interpolate( {startAngle: 0, endAngle:0 }, b)
			return (t) ->
				arc(i(t))

		getColor = (i) ->

			console.log 'getting color: ', i 
			
			if scope.chartColors && i < scope.chartColors.length
				console.log 'chartColor:' , scope.chartColors[i]
				scope.chartColors[i]
			else
				console.log color(i)
				color(i)
		

		scope.$watch 'data', (newVal) ->
			scope.render(newVal) if newVal


		scope.render = (data) ->
			console.log 'rendering', data
			d3.select(element[0]).selectAll('*').remove()
			vis = d3.select(element[0])
			.append('svg:svg')
			.data([data])
				.attr('width', width)
				.attr('height', height)
			.append('svg:g')
				.attr('transform','translate(' + r + ',' + r + ')')
			


			

			pie = d3.layout.pie()
				.value( (d) -> -d.value)

			arcs = vis.selectAll('g.slice')
				.data(pie)
				.enter()
					.append('svg:g')
						.attr('class','slice')

				
	  

			arcs.selectAll('*').remove()

			arcs.append('svg:path')
				.attr('fill', (d,i) -> getColor(i))
				.attr('d', arc)
				.transition()
					.duration(duration)
					.delay( (d,i) -> i * 50)
					.attrTween('d', tweenPie)

			arcs.append('svg:text')
				.style('opacity',0)
				.attr('fill','#fff')
				.attr('transform', (d) ->
					d.innerRadius = 0
					d.outerRadius = r
					return 'translate(' + arc.centroid(d) + ')'
				)
				.transition()
					.duration(duration)
					.delay(duration)
					.style('opacity',1)
				.attr('text-anchor', 'middle')
				.text( (d,i) -> data[i].label )

	]
