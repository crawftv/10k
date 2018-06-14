"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const functions = require("firebase-functions");
// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript
// export const helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);
exports.createNewUserDoc = functions.auth.user().onCreate((user) => {
    const uid = user.uid;
    const userEmail = user.email;
    return admin.firestore().doc('users/' + uid).set({
        email: userEmail,
        uid: uid,
    });
});
//# sourceMappingURL=index.js.map