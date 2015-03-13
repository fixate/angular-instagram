angular.module('fxInstagram', []).service('Instagram', [
  '$http', function($http) {
    return {
      get: function(userId, config, cb) {
        var URL;
        URL = "https://api.instagram.com/v1/users/" + userId + "/media/recent";
        return $http.jsonp(URL, config).success(function(res) {
          return cb(res.data);
        });
      }
    };
  }
]).directive('fxInstagram', [
  'Instagram', function(Instagram) {
    return {
      restict: 'AECM',
      controller: [
        '$scope', '$attrs', 'Instagram', function($scope, $attrs, Instagram) {
          var config;
          config = {
            params: {
              client_id: $attrs.clientId,
              count: $attrs.count,
              max_timestamp: $attrs.maxTimestamp,
              min_timestamp: $attrs.minTimestamp,
              callback: $attrs.callback || 'JSON_CALLBACK'
            }
          };
          $scope.instaImgs = [];
          return Instagram.get($attrs.userId, config, function(images) {
            return $scope.instaImgs = images;
          });
        }
      ]
    };
  }
]);
