const express = require("express");
const mcqsRouter = express.Router();
 const multer = require("multer");
const fs = require("fs");
const MCQS = require("../models/mcqs.js")
 

//-------multer method to uplad the pdf file
  const upload = multer({
    storage: multer.diskStorage({
      destination: (req, file, cb) => {
        const courseName = req.body.courseName;
        const uploadPath = `./uploads/${courseName}`;
  
        // Create the directory if it doesn't exist
        if (!fs.existsSync(uploadPath)) {
          fs.mkdirSync(uploadPath, { recursive: true });
        }
  
        cb(null, uploadPath);
      },
      filename: (req, file, cb) => {
        cb(null, `${file.originalname}`);
      },
    }),
  });

  
//------------- end point to upload  mcq's
  mcqsRouter.post("/api/v1/upload-mcqs", upload.single("pdf"), async (req, res) => {
  try {
    const { title, streamName } = req.body;

    // Assuming your server is running on http://your-server
    const pdfUrl = `http://localhost:3000/uploads/${streamName}/${req.file.filename}`;

    const newMCQS = new MCQS({
      title,
      streamName,
      pdfUrl,
    });

    await newMCQS.save();

    res.json(newMCQS);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal server error" });
  }
});



// Get all MCQs
mcqsRouter.get('/api/v1/get-all-mcqs', async (req, res) => {
    try {
      // Fetch all MCQs from the database
      const allMCQs = await MCQS.find();
  
      if (!allMCQs || allMCQs.length === 0) {
        return res.status(404).json({ message: 'No MCQs found.' });
      }
  
      res.json({ status: "success", mcqs: allMCQs});
    } catch (error) {
      console.error(error);
  
      // Check for specific errors (e.g., database connection issues)
      if (error.name === 'MongoError') {
        return res.status(500).json({ error: 'Database error. Please try again later.' });
      }
  
      res.status(500).json({ error: 'Internal server error' });
    }
  });
  


// Delete a note by ID
mcqsRouter.delete('/api/v1/delete-mcq/:mcqId', async (req, res) => {
  try {
    const mcqId = req.params.mcqId;

    // Find and delete the note by ID
    const deletedMCQS = await MCQS.findByIdAndDelete(mcqId);

    if (!deletedMCQS) {
      return res.status(404).json({ error: 'Note not found' });
    }

    res.json({ message: 'Mcq deleted successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

  module.exports = mcqsRouter;