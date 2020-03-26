const admin = require('firebase-admin');
const serviceAccount = rqeuire('./SportyAdminSDK.json');

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

module.exports = admin;