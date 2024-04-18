import express from "express";
import { addEvent, getEvent } from "../controller/event.controller.js";

const router = express.Router();

router.post("/", addEvent)
router.get("/:id", getEvent)



export default router;