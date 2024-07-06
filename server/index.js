//PACKAGE IMPORTS
require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

//LOCAL IMPORTS
const authRouter = require("./routes/auth");

//INIT
const PORT = process.env.PORT || 5000;
const mongoDbUri = process.env.MONGODB_URI || "mongodb://localhost:27017/auth";
const app = express();

//MIDDLEWARE
app.use(express.json());
app.use(cors());
app.use(authRouter);

mongoose
  .connect(
    "mongodb+srv://zior:nEGSe16KwmVjFV9T@cluster0.dcrqwef.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"
  )
  .then(console.log("Connected to MongoDB"))
  .catch((err) => {
    console.log(err);
  });

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

console.log("this is the server/index.js file");
