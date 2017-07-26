var User = require('../models/user');
var Blog =  require('../models/blog');
var Profile = require('../models/profile');
var jwt = require('jsonwebtoken');
var server = require('../../server');
var docClient = new server.AWS.DynamoDB.DocumentClient();

var secret = 'jerry';

 module.exports = function(router) {

// 	// http://localhost:3000/api/users
// 	// USER REGISTRATION
	// router.post('/users', function(req, res){
	// 	var user = new User();
	// 	user.username = req.body.username;
	// 	user.password = req.body.password;
	// 	user.email = req.body.email;
	// 	if(req.body.username == null || req.body.username == '' || req.body.password == null || req.body.password == '' || req.body.email == null || req.body.email == ''){
	// 		//res.send("Ensure all the 3 fields are provided");
	// 		res.json({success: false, message: "Ensure all the 3 fields are provided"});
	// 	}else{
	// 		user.save(function(err){
	// 		if(err) {
	// 		 //	res.send("Username or email already exists! ");
	// 		 	res.json({success: false, message: "Username or email already exists! "});

	// 		}else {
	// 				res.json({success: true, message:"User created!"});
	// 		}

	// 	});

	// 	}
		
	// });

// //copy of registration
	router.post('/users', function(req, res){

		// console.log("inside users");
		 var email = req.body.email;
		 var username = req.body.username;
		 var password = req.body.password;
		 if(req.body.username == null || req.body.username == '' || req.body.password == null || req.body.password == '' || req.body.email == null || req.body.email == ''){
		 	res.json({success: false, message: "Ensure all the 3 fields are provided"});
		 }else{
		 	// GETTING ITEM based on email
		 	// Checking if email already exists
		     		     
		    var params = {
		            TableName: "userTable",
		          	Key:{
				        "email": email
				    }
		        }
		  	docClient.get(params, function(err, data) {
                    if (err) {
                        console.error("Unable to read item. Error JSON:", JSON.stringify(err, null, 2));
                    } else {
                        //console.log("GetItem succeeded:", JSON.stringify(data, null, 2));
                        console.log("GETTING Item", data);
                        var jsonObject = JSON.stringify(data, null, 2);
                        var obj = JSON.parse(jsonObject)
                        console.log(obj.Item.email);

                        if (obj.Item.email == email) {
                            res.json({ success: false, message: "This email has been already used for registration!" });
                        }

                        if (obj.Item.username == username) {
                            res.json({ success: false, message: "Please use a different username!" });

                            // }else{
                            //  	   	var params = {
                            //  					TableName : 'userTable',
                            // 		Item: {
                            // 			email: req.body.email,
                            // 			username: req.body.username,
                            // 			password: req.body.password
                            // 		    }
                            // 		}

                            // 	docClient.put(params, function(err, data) {
                            // 		  if (err) {
                            // 		  	res.json({success: false, message: "Username or email already exists! "});
                            // 		  	console.log(err);
                            // 		  }
                            // 		  else {
                            // 		  	res.json({success: true, message:"User created!"});
                            // 		  	//console.log(data);
                            // 		  }
                            // 	});

                            //  	   }
                        }
                    }
				});
			
		 }


		 
			

		
		// var params = {
  		// 			TableName : 'userTable',
		// 	Item: {
		// 		email: req.body.email,
		// 		username: req.body.username,
		// 		password: req.body.password
		// 	    }
		// 	}

		// docClient.put(params, function(err, data) {
		//   if (err) console.log(err);
		//   else console.log(data);
		// 	});
		
	});


	// USER LOGIN
	// http://localhost:3000/api/authenticate

	router.post('/authenticate', function(req, res){
		User.findOne({username: req.body.username}).select('email username password').exec(function(err, user){
			if (err) throw err;

			if(!user){
				res.json({success:false, message:"Couldn't authenticate user"});
			}else{

				if(req.body.password){
					var validPassword = user.comparePassword(req.body.password);
				}else{
					 res.json({success: false, message: "No password provided! "});

				}
				if(!validPassword){
					res.json({success: false, message: "Couldn't authenticate! "});
				}else{
					var token = jwt.sign({username: user.username, email: user.email}, secret, {expiresIn: '24h'});
					res.json({success: true, message:"User authenticated!", token: token});
			
				}
			}
		});
	});


	router.use(function(req, res, next){
		var token = req.body.token || req.body.query || req.headers['x-access-token'];

		if(token){
			// verify token

			jwt.verify(token, secret, function(err, decoded) {
			 	if(err){
			 		res.json({success: false, message: 'Token invalid'});
			 	} else{
			 		req.decoded = decoded;
			 		next();
			 	}
			});


		}else{
			res.json({success: false, message: 'No token provided!'});
		}
	});


	router.get("/shit", function(req, res) {
		console.log("SHIT")
		res.send("<h1>Fuck you!</h1")		
	})


	router.post('/me', function(req, res){
		res.send(req.decoded);
	});


	// BLOG POST
	router.post("/blogpost", function createPost(req,res){
		// var blog =  new Blog();
		// blog.title = req.body.title;
		// blog.content = req.body.content;
		// blog.posted = req.body.posted;
	 	
	 // 	var post = new Blog();
		
		// post.title = req.body.title;
		// post.content = req.body.content;
		// post.save(function(err) {
		// 	if(err)
		// 		console.log(err)
		// })

		Blog.create(req.body).then(
		function(postObj){
			res.json(200);

		},
		function(error){
			res.sendStatus(400);
		});
		// Blog.create(req.body, function(err, succ) {
		// 	if(err)
		// 		console.log(err)
		// 	else
		// 		console.log(succ)
 	// 	})
	});

	// PROFILE -- createProfile
	router.post("/profilepost", function createProfile(req,res){	

		Profile.create(req.body).then(
		function(profObj){
			res.json(200);

		},
		function(error){
			res.sendStatus(400);
		});
		
	});

	router.get("/blogpost", function getAllPosts(req,res){
		Blog.find().then(
		function(posts){
			console.log(posts);
			res.json(posts);
		},
		function(err){
			res.sendStatus(400);
		});
	});


	router.get("/blogposts/:bloggedby", function getPostsByName(req,res){
		var name = req.params.bloggedby;
		console.log(name);
		Blog.find({bloggedBy: name}).then(
		function(posts){
			console.log("getPostsByName function");
			console.log(posts);	
			res.json(posts);
		},
		function(err){
			res.sendStatus(400);
		});
	});


	// PROFILE -- getProfilesByName
	router.get("/profileposts/:postedby", function getProfilesByName(req,res){
		var name = req.params.postedby;
		console.log(name);
		Profile.find({postedBy: name}).then(
		function(profs){
			console.log("getProfilesByName function");
			console.log(profs);	
			res.json(profs);
		},
		function(err){
			res.sendStatus(400);
		});
	});


	router.delete("/blogpost/:id", function deletePost(req, res){
	var postId = req.params.id;
	Blog
	.remove({_id: postId})
	.then(
		function(status){
			res.sendStatus(200);
		},
		function(){
			res.sendStatus(400);
		});
});

	// PROFILE -- deleteProfile
	router.delete("/profilepost/:id", function deleteProfile(req, res){
	var profId = req.params.id;
	Profile
	.remove({_id: profId})
	.then(
		function(status){
			res.sendStatus(200);
		},
		function(){
			res.sendStatus(400);
		});
	});


	router.get("/blogpost/:id", function getPostById(req, res){
	var postId = req.params.id;
	console.log(postId);
	Blog
	.findById(postId)
	.then(
		function(post){
			res.json(post);
		},
		function(err){
			res.sendStatus(400);
		});
});

	// PROFILE -- getProfileById
	router.get("/profilepost/:id", function getProfileById(req, res){
	var profId = req.params.id;
	console.log("getProfileById first");
	Profile
	.findById(profId)
	.then(
		function(prof){
			res.json(prof);
			console.log("getProfileById success");
		},
		function(err){
			res.sendStatus(400);
		});
});






	router.put("/blogpost/:id", function updatePost(req, res){
	var postId = req.params.id;
	var post = req.body;
	Blog
	.update({_id: postId},{
		title: post.title, content: post.content
	})
	.then(
		function(status){
			res.sendStatus(200);
		},
		function(err){
			res.sendStatus(400)
		});
});


	// PROFILE -- updateProfile

	router.put("/profilepost/:id", function updateProfile(req, res){
	var profId = req.params.id;
	var prof = req.body;
	Profile
	.update({_id: profId},{
		skills: prof.skills, experience: prof.experience
	})
	.then(
		function(status){
			res.sendStatus(200);
		},
		function(err){
			res.sendStatus(400)
		});
});


	return router;
}




// jwt.verify(token, 'shhhhh', function(err, decoded) {
//   console.log(decoded.foo) // bar
// });



