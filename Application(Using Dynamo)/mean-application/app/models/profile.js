var mongoose = require('mongoose');
var Schema = mongoose.Schema;


var profileSchema = new Schema({
	skills: {type: String, required: true},
	experience: String,
	postedBy: {type: String, required: true, default: "Unknown"}
});


module.exports = mongoose.model('Profile', profileSchema);
//module.exports = mongoose.model('Blog', postSchema1);