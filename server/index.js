// IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");
 // IMPORTS FROM OTHER FILES
 const authRouter = require("./routers/auth_routers.js")
 const courseRouter = require("./routers/course_route.js");
 const mcqsRouter = require("./routers/mcq_router.js");
// INIT
const PORT = process.env.PORT || 3000;
const IP_ADDRESS = '192.168.1.186';
const app = express();
const DB =
  "mongodb+srv://tiwariabishek44:Forgetme1@cluster0.3xygkqd.mongodb.net/?retryWrites=true&w=majority";

// middleware
app.use(express.json());
 app.use(authRouter);
app.use(courseRouter);
app.use(mcqsRouter);
app.use('/uploads', express.static('uploads'));


// Connections
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });
  app.listen(3000, '192.168.1.69', () => {
    console.log('Server is running on http://192.168.1.186:3000');
  });
  