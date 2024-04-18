import eventModal from "../Model/event.modal.js";

export const addEvent = async(req, res)=>{
    console.log(req.body)
    try {
        const newEvent = new eventModal(req.body)
        await newEvent.save();
        res.status(201).send("event added to database")        
    } catch (error) {
        console.log("error occur")
    }
}

export const getEvent = async(req, res)=>{
    const id = Number(req.params.id)
    try {
        const event = await eventModal.find({ event_id : id} );
        res.status(200).send(event);         
    } catch (error) {
        console.log("error our")
    }
}
