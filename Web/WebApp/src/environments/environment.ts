// This file can be replaced during build by using the `fileReplacements` array.
// `ng build --prod` replaces `environment.ts` with `environment.prod.ts`.
// The list of file replacements can be found in `angular.json`.

export const environment = {
  production: false,
  firebaseConfig :{
    apiKey: "AIzaSyDsC7jVDrnaBRqSVWot22OqBw9RCOEpS5Y",
    authDomain: "panchitaapp-7cc6f.firebaseapp.com",
    databaseURL: "https://panchitaapp-7cc6f.firebaseio.com",
    projectId: "panchitaapp-7cc6f",
    storageBucket: "panchitaapp-7cc6f.appspot.com",
    messagingSenderId: "500342663235",
    appId: "1:500342663235:web:9cbf048b17c3b401a44cf6",
    measurementId: "G-KS6ME95C0K"
  },
  urlPush:'https://fcm.googleapis.com/fcm/send'
};

/*
 * For easier debugging in development mode, you can import the following file
 * to ignore zone related error stack frames such as `zone.run`, `zoneDelegate.invokeTask`.
 *
 * This import should be commented out in production mode because it will have a negative impact
 * on performance if an error is thrown.
 */
// import 'zone.js/dist/zone-error';  // Included with Angular CLI.
