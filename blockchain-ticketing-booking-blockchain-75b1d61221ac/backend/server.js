import express from "express";
import mongoose from "mongoose";
import router from "./routes/event.route.js";
import cors from "cors";

const app = express();
mongoose.connect("mongodb://127.0.0.1:27017/event-ticketing-system")
app.use(express.json())
app.use(cors({ origin: "*", credentials: true }));
// routes
// event data get and post
app.use(express.urlencoded({extended: false}))
app.use("/api/uploads/",router)



app.listen('8000', ()=>{console.log("server is up and running")})