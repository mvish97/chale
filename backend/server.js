require('dotenv').load();
const http = require('http');
const path = require('path');
const AccessToken = require('twilio').jwt.AccessToken;
const ChatGrant = AccessToken.ChatGrant;
const express = require('express');
// Create Express webapp
const app = express();
app.use(express.static(path.join(__dirname, 'public')));

/*
Generate an Access Token for a chat application user - it generates a random
username for the client requesting a token, and takes a device ID as a query
parameter.
*/
app.get('/token', (request, response) => {
  const appName = 'Chale';
  const identity = request.query.id;
  const deviceId = request.query.device;

  // Create a unique ID for the client on their current device
  const endpointId = appName + ':' + identity + ':' + deviceId;

  // Create a "grant" which enables a client to use Chat as a given user,
  // on a given device
  const chatGrant = new ChatGrant({
    serviceSid: "IS67f535d1825d420c85a481139c9a0292",
    endpointId: endpointId,
  });

  // Create an access token which we will sign and return to the client,
  // containing the grant we just created
  const token = new AccessToken(
    "AC69aff9820d45b10e33545a65ba058e0c",
    "SKb44c93e4eecf5e4568135865b5782d7c",
    "FIY4j33ZH0PWyt5QNlUZBPJRf4jVrrl0"
  );
  token.addGrant(chatGrant);
  token.identity = identity;

  // Serialize the token to a JWT string and include it in a JSON response
  response.send({
    identity: identity,
    token: token.toJwt(),
  });
});

// Create http server and run it
const server = http.createServer(app);
const port = process.env.PORT || 3000;
server.listen(port, () => {
  console.log('Express server running on *:' + port);
});
