var mongoose = require('mongoose');
var Schema = mongoose.Schema;


var postSchema = new Schema({
	title: {type: String, required: true},
	content: String,
	posted: {type: Date, default: Date.now},
	bloggedBy: {type: String, required: true, default: "Unknown"}
});


module.exports = mongoose.model('Blog', postSchema);
//module.exports = mongoose.model('Blog', postSchema1);