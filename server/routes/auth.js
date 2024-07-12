//PACKAGE IMPORTS
const express = require("express");
const bcypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

//LOCAL IMPORTS
const User = require("../models/User");

//INIT
const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
  const { name, email, password } = req.body;
  console.log(`Name: ${name}, Email: ${email}, Password: ${password}`);

  //push the user to the database
  try {
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ msg: "User already exists" });
    }

    //hash the password
    const salt = await bcypt.genSalt(10);
    const hashedPassword = await bcypt.hash(password, salt);

    //create a new user
    let user = new User({ name, email, password: hashedPassword });
    user = await user.save();
    res.status(201).json({ message: "User created successfully" });
  } catch (err) {
    res.status(500).json({ err: `Internal Server Error ${err.message}` });
  }
});

authRouter.post("/api/login", async (req, res) => {
  const { email, password } = req.body;
  console.log(`Email: ${email}, Password: ${password}`);

  try {
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(400).json({ msg: "User does not exist" });
    } else {
      const isMatch = await bcypt.compare(password, user.password);
      if (!isMatch) {
        return res.status(400).json({ msg: "Invalid credentials" });
      }
      const token = jwt.sign({ userId: user._id }, "PasswordKey", {
        expiresIn: "1h",
      });
      res.status(200).json({ token, ...user._doc });
    }
  } catch (err) {
    res.status(500).json({ err: `Internal Server Error ${err.message}` });
  }
});

module.exports = authRouter;
console.log("this is the server/routes/auth.js file");
