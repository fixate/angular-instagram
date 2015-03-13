# Angular Instagram

Easily get instagram images using a client ID and user ID.

[demo](http://fixate.github.io/angular-instagram/demo)

## Installation

```shell
$ bower install angular-instagram
```

## Setup

Add the `fxInstagram` module as a dependency for your app:

```javascript
angular.module('myApp', ['fxInstagram']);
```

Loop over the results:

```html
<div fx-instagram client-id="[your client ID]" user-id="[your user ID]" count="3">
  <img ng-repeat="img in instaImgs" ng-attr-src="{{ img.images.standard_resolution.url }}" alt="">
</div>
```

### Parameters

Only a `client-id` is required for the request's params, the others are optional:

```html
<div fx-instagram
  client-id="[my app id]"
  count="20"
  max-timestamp="[max timestamp]"
  min-timestamp="[min timestamp]"
  callback="">
  ...
</div>
```

## Getting Instagram Deets

[User ID](http://jelled.com/instagram/lookup-user-id#)
[Client ID](https://instagram.com/developer/)

## License

MIT: http://fixate.mit-license.org/
