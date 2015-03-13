angular.module('fxInstagram', [])

	.service 'Instagram', [
		'$http', ($http) ->
			get: (userId, config, cb) ->
				URL = "https://api.instagram.com/v1/users/#{userId}/media/recent"

				$http.jsonp(URL, config)
					.success (res) ->
						cb res.data
	]

	.directive 'fxInstagram', [
		'Instagram', (Instagram) ->
			restict: 'AECM'
			controller: ['$scope', '$attrs', 'Instagram', ($scope, $attrs, Instagram) ->
				config =
					params:
						client_id: $attrs.clientId,
						count: $attrs.count,
						max_timestamp: $attrs.maxTimestamp,
						min_timestamp: $attrs.minTimestamp,
						callback: $attrs.callback || 'JSON_CALLBACK'

				$scope.instaImgs = []

				Instagram.get $attrs.userId, config, (images) ->
					$scope.instaImgs = images
			]
	]
