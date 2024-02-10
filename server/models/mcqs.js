const mongoose = require("mongoose");

const mcqSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
  },
  streamName: {
    type: String,
    required: true,
  },
  pdfUrl: {
    type: String,
    required: true,
  },
   
});

const MCQS = mongoose.model("MCQS", mcqSchema);

module.exports = MCQS;
