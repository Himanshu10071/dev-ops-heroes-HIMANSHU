const http = require("http");
const add = (a, b) => a + b;
module.exports = { add };

if (require.main === module) {
  http.createServer((req, res) => res.end("Hello from CI/CD demo!"))
    .listen(3000, () => console.log("Running on 3000"));
}