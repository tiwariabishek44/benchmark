const express = require("express");
const User = require("../models/user_models.js");
const bcryptjs = require("bcryptjs");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth.js");
   
authRouter.post('/api/v1/signup', async (req, res) => {
    try {
      console.log("----INSIDE THE REGISTER API")
      const { name, email, password, phone, userType, isVerified,stream } = req.body;
  
      // Check if a user with the provided email already exists
      const existingUser = await User.findOne({ email });
      if (existingUser) {
        return res.status(400).json({ message: 'Email is already in use. Please choose a different email.' });
      }
  
      // Hash the password
      const hashedPassword = await bcryptjs.hash(password, 10);
  
      // Generate a JWT token
      const token =  ''
  
      // Create a new user with the token
      const user = new User({ name, email, password: hashedPassword, phone, userType, isVerified, token ,stream});
      await user.save();
  
      res.json(user);
      console.log("----REGISTER SUCCESS")

    } catch (error) {
      console.error(error); // Log the error for debugging
  
      // Check if the error is a duplicate key error
      if (error.code === 11000 && error.keyPattern && error.keyPattern.email) {
        return res.status(400).json({ message: 'Email is already in use. Please choose a different email.' });
      }
  
      res.status(500).json({ message: 'Internal server error.' });
    }
  });
  
// Login route
authRouter.post("/api/v1/signin", async (req, res) => {
    try {
      const { email, password } = req.body;
  
      const user = await User.findOne({ email });
      if (!user) {
        return res
          .status(400)
          .json({ msg: "User with this email does not exist!" });
      }
  
      const isMatch = await bcryptjs.compare(password, user.password);
      if (!isMatch) {
        return res.status(400).json({ msg: "Incorrect password." });
      }
  
      const tokens = jwt.sign({ id: user._id }, "passwordKey");
      const updatedUser = await updateUserToken(user._id,tokens);
      if (updatedUser) {
        // If the token update is successful
        console.log('Token update successful');
        console.log(updatedUser.token);
        console.log("---this is the token"+tokens)
       return  res.json({ msg: 'Sign in successful', tokens, userData: updatedUser._doc });
      } else {


        console.log('Token update failed');
       return  res.status(500).json({ msg: 'Token update failed. Please try again.' });
      }
     } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });


//----------update the user token when login ---------

  const updateUserToken = async (userId, newToken) => {
    try {
      // Find the user by user ID
      const user = await User.findById(userId);
  
      if (!user) {
        // Handle the case where the user is not found
        return null;
      }
  
      // Update the user's token field
      user.token = newToken;
      
      // Save the updated user to the database
      await user.save();
      
  
      return user;
    } catch (error) {
      // Handle any errors during the process
      console.error('Error updating user token:', error);
      throw error;
    }
  };
  
  

 
  
  // Get user details by passing the token
  authRouter.get("/api/v1/get-user-details/:userId",  async (req, res) => {
    try {
      console.log("user data is get succesfully");
      const userId = req.params.userId;

      // The user details are available in req.user due to the auth middleware
      const user = await User.findById(userId);
  
      if (!user) {
        return res.status(404).json({ error: "User not found" });
      }
  
      // Return the user details excluding the password and token
      res.json({
        name: user.name,
        email: user.email,
        phone: user.phone,
        stream :user.stream,
        userType: user.userType,
        isVerified: user.isVerified,
      });
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: "Internal server error" });
    }
  });
  
   

module.exports = authRouter;