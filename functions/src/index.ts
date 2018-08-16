import * as functions from 'firebase-functions';

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

// export const helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);
export const createNewUserDoc = functions.auth.user().onCreate((user) => {
  const uid = user.uid;

  return admin.firestore().doc(uid+'/user').set({
    goalName: "Create Five Goals",
    endGoal: 5,
    goalProgress: 0,
    addProgress: "0",
    uid: user.uid,
    dateCreated : new Date(),
    lastUpdate : new Date()

  })
});
