var mongoose = require('mongoose');
var Schema = mongoose.Schema;
// var bycrpt = require('bycrpt-nodejs');

var userSchema = new Schema({
  username:  {type: String, lowercase: true, required: true, unique: true},
  password: {type: String, required: true},
  email: {type: String, lowercase: true, required: true, unique: true}
});

// userSchema.pre('save', function(next) {

//   var user = this;
//   bycrpt.hash(user.password, null, null, function(err, hash){
//     if(err) return next(err);
//     user.password =hash;
//     next();
//   });
// });
 
userSchema.methods.comparePassword=function(password){
	return  this.password == password;
}


module.exports = mongoose.model('User', userSchema);