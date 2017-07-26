## This is a markdown file



Steps for Securing Infrastructure.
1) Used  Github Student Developer pack to purshase one year SSL certificates from Namecheap.
2) Configured CSR code for Nodejs
3) Installed "npm install openssl" to generate .csr file for installing SSL certificates.
4) On namecheap dashboard, clicked on SSL certificates and pressed Activate button.
5) Copied and pasted the generated csr file.
6) We chose Email as DCV method.
7) Then we created a record with CNAME under the hosted zone "neu-csye6225-spring2017-team-9.info.".
8) Wrote the installation script required for nodejs in Server.js file of our application.
