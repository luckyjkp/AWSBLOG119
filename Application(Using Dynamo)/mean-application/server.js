var express = require('express');
var app = express();
var morgan = require('morgan');


var mongoose = require('mongoose');


// FOR DYNAMO DB
// var server = require('http').createServer(app);


let AWS = require('aws-sdk');
	AWS.config = {
  "apiVersion": "2017-03-21",
  "accessKeyId": "AKIAJDVLBOATWXNIJLTA",
  "secretAccessKey": "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",
  "region":"us-east-1"
  //"endpoint": "http://"
		}


module.exports = {
	AWS : AWS
}




//console.log(dynamodb);

// server.listen(port, function () {
//   console.log('Server listening at port %d', port);
// });



// END OF DYNAMO
var bodyParser = require('body-parser');
var router = express.Router();
var appRoutes = require('./app/routes/api')(router);
var path = require('path');
app.use(morgan('dev'));
app.use(bodyParser.json()); // for parsing application/json
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(__dirname + '/public'));

app.use('/api',appRoutes);
//console.log(val);

// mongoose.connect('mongodb://localhost:27017/meanapp', function(err){
// 	if(err) {
// 		console.log("Not connected to the MongoDB" + err);
// 	}else{
// 		console.log("Successfully connected to the MongoDB");
// 	}
// });

app.get('*',function(req, res){
	res.sendFile(path.join(__dirname + '/public/app/views/index.html'));

});
/*
app.listen(3000, function(){
	console.log("Running the server!!!"); 
});

/* Adding code for https server */
var https = require('https');
var fs = require('fs');

var options = {
    key: fs.readFileSync('./certs/www.neu-csye6225-spring2017-team-9.info.key'),
    ca: fs.readFileSync('./certs/www_neu-csye6225-spring2017-team-9_info.ca-bundle'),
    cert: fs.readFileSync('./certs/www_neu-csye6225-spring2017-team-9_info.crt')
};

var server = https.createServer(options, app);

server.listen(443, function () {
    console.log("Running the server!!!");
});
