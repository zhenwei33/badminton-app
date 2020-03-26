const express = require('express');
const app = express();
const morgan = require('morgan');

app.use(morgan('dev'));

app.post('/register', (req, res) => {
    JSON.parse(req.body);
});
module.exports = app;