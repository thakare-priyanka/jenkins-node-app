#!/bin/bash
yum update -y
curl -sL https://rpm.nodesource.com/setup_16.x | bash -
yum install -y nodejs git
 
mkdir -p /home/ec2-user/node-app
cat <<EOF > /home/ec2-user/node-app/app.js
const http = require('http');
const hostname = '0.0.0.0';
const port = 3000;
 
const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello from Node.js app on EC2!');
});
 
server.listen(port, hostname, () => {
  console.log(\`Server running at http://\${hostname}:\${port}/\`);
});
EOF
 
cd /home/ec2-user/node-app
npm init -y
node app.js &
 
