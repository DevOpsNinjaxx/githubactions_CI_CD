const express = require('express');

const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Hello World! FROM GITHUB ACTION!!');
});

app.listen(port, () => {
//    console.log(`Example app listening on port ${port}`);
});

module.exports = app;