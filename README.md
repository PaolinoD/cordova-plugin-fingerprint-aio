# Cordova Plugin Fingerprint All-In-One
## **A** ndroid and **IO** s

This plugin is an attempt to provide a single interface for accessing fingerprint hardware on both Android 6+ and iOS.

## Features

* Check if fingerprint scanner is available
* Fingerprint authentication

### Platforms

* Android
* iOS

## How to use

### Check if fingerprint authentication is available
```javascript
Fingerprint.isAvailable(isAvailableSuccess, isAvailableError);

    function isAvailableSuccess(result) {
      alert("Fingerprint available");
    }

    function isAvailableError(message) {
      alert(message);
    }
```

### Show authentication dialogue
```javascript
Fingerprint.show({
      clientId: "Fingerprint-Demo",
      clientSecret: "password" //Only necessary for Android
    }, successCallback, errorCallback);

    function successCallback(){
      alert("Authentication successfull");
    }

    function errorCallback(err){
      alert("Authentication invalid " + err);
    }
```

[Example](https://github.com/NiklasMerz/fingerprint-aio-demo/blob/master/www/js/controllers.js)

[ngCordova Example](https://github.com/NiklasMerz/fingerprint-aio-demo/tree/ng-cordova)

Demo app: https://github.com/NiklasMerz/fingerprint-aio-demo

## Thanks to the authors of the original fingerprint plugin:

[Android](https://github.com/mjwheatley/cordova-plugin-android-fingerprint-auth)

[iOS](https://github.com/EddyVerbruggen/cordova-plugin-touch-id)

## License

* Project and iOS source -> MIT
* Android source -> MIT and Apache 2.0
