const http = require('http');
 
const server = http.createServer((req, res) => {
  res.end('Hello from Node app on aws..!');
});
 
server.listen(3000, () => {
  console.log('Server running on port 3000');
});
