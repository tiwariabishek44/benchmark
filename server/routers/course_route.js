const express = require("express");
const courseRouter = express.Router();
const Course = require("../models/course_model.js")
const multer = require("multer");
const fs = require("fs");
const Note = require("../models/notes_model.js")


// -----------Create a new course// 
courseRouter.post("/api/v1/create-course", async (req, res) => {
    try {
      const { name, description, price } = req.body;
  
      // Check if a course with the same name already exists
      const existingCourse = await Course.findOne({ name });
      if (existingCourse) {
        return res.status(400).json({ error: "Course with the same name already exists" });
      }
  
      // Create a new course if no existing course found
      const newCourse = new Course({
        name,
        description,
        price,
        notes: [],
      });
  
      const savedCourse = await newCourse.save();
      res.json(savedCourse);
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: "Internal server error" });
    }
  });
  

  // --------Get a course all  note 
courseRouter.get('/api/v1/get-course/:courseName', async (req, res) => {
  try {
    const courseName = req.params.courseName;

    // Find the course by name
    const course = await Course.findOne({ name: courseName });

    if (!course) {
      return res.status(404).json({ error: 'Course not found' });
    }

    res.json(course);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});



// update the course price--------
 
courseRouter.put("/api/v1/update-course/:courseId", async (req, res) => {
    try {

       const courseId = req.params.courseId;
      const { price } = req.body;
  
      // Find the course by ID
      const course = await Course.findById(courseId);
  
      if (!course) {
        return res.status(404).json({ error: "Course not found" });
      }
  
      // Update the course's price
      course.price = price;
      
      // Save the updated course
      const updatedCourse = await course.save();
  
      res.json(updatedCourse);
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: "Internal server error" });
    }
  });


  //-------upload the pdf file 
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

//----upload the  notes 

courseRouter.post("/api/v1/upload-note", upload.single("pdf"), async (req, res) => {
  try {
    const { title, courseName } = req.body;

    // Assuming your server is running on http://your-server
    const pdfUrl = `http://localhost:3000/uploads/${courseName}/${req.file.filename}`;

    const newNote = new Note({
      title,
      courseName,
      pdfUrl,
    });
 // Find the course by courseName
 const course = await Course.findOne({ name: courseName });

 if (!course) {
   return res.status(404).json({ error: "Course not found" });
 }

 // Append the new note to the course's notes field
 course.notes.push(newNote);

 // Save the updated course
 await course.save();

 res.json(newNote);
} catch (error) {
 console.error(error);
 res.status(500).json({ error: "Internal server error" });
}
});


  // Delete a note by ID
courseRouter.delete('/api/v1/delete-note/:noteId', async (req, res) => {
  try {
    const noteId = req.params.noteId;

    // Find the course that contains the note
    const course = await Course.findOne({ 'notes._id': noteId });

    if (!course) {
      return res.status(404).json({ error: 'Course not found or Note not associated with any course' });
    }

    // Find the index of the note within the course's notes array
    const noteIndex = course.notes.findIndex(note => note._id.toString() === noteId);

    if (noteIndex === -1) {
      return res.status(404).json({ error: 'Note not found within the course' });
    }

    // Remove the note from the array
    course.notes.splice(noteIndex, 1);

    // Save the updated course
    await course.save();

    res.json({ message: 'Note deleted successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

  module.exports = courseRouter;

  