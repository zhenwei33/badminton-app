const express = require('express');
const app = express();
const morgan = require('morgan');

app.use(morgan('dev'));

app.post('chat', (req, res) => {
    var message = JSON.parse(req.body);
    console.log(message);
});

module.exports = app;