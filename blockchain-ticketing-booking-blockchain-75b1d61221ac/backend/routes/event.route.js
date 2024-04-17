import express from "express";
import { addEvent } from "../controller/event.controller.js";

const router = express.Router();

router.post("/", addEvent)

export default router;