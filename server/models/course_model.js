const mongoose = require("mongoose");
const Note = require("../models/notes_model.js")
const courseSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  description: {
    type: String,
    required: true,
  },
  price: {
    type: Number,
    required: true,
  },
  notes: [Note.schema], // Using Note schema from noteModel
});

const Course = mongoose.model("Course", courseSchema);

module.exports = Course;
