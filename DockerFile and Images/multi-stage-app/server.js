const express = require('express');

const app = express();
const port = 8080;

app.get('/', (_request, response) => {
  response.send('<!doctype html><html><head><title>Docker Multi-Stage Build</title></head><body><h1>Hello World from Docker multi-stage build</h1></body></html>');
});

app.listen(port, '0.0.0.0', () => {
  console.log(`Multi-stage app listening on port ${port}`);
});