
import React, { useState, useEffect } from 'react'
import { AppConstants, AppText, handleDateTime } from '../../helpers/AppConstants'
import PrimaryButton from './PrimaryButton'
import {getEventDetails} from "../../helpers/contractInteraction.jsx"


export default function Card({ item, setShowBuyTicket, setShowEdit, setSelectedEvent, selectedAccount, showBuy = true }) {
    const [show, setShow] = useState(false)
    const { description, eventEndTime, eventStartTime, image_url, ticketCount, ticket_price, title, id} = item
    useEffect(()=>{
        async function check() {
            let result = await getEventDetails(id)
            if ((result.organizer).toLowerCase() == selectedAccount){  
               setShow(true)
            }
    
       }
       check()
    }
        
        
        , [show, selectedAccount]);
    return (
        <div className="col-lg-4 col-md-6">
            <div className="hotel">
                <div className="hotel-img">
                    <img
                        src={(image_url)}
                        alt="Hotel 1"
                        className="img-fluid"
                    />
                </div>
                <h3><a href="#">{title}</a></h3>
                <p>{description}</p>
                <EventDetailItem
                    title={AppText.tickets}
                    desc={parseInt(ticketCount)}
                />
                <EventDetailItem
                    title={AppText.ticket_price_wei}
                    desc={parseInt(ticket_price)}
                />
                <EventDetailItem
                    title={AppText.event_starting_date_time}
                    desc={handleDateTime(parseInt(eventStartTime))}
                />
                <EventDetailItem
                    title={AppText.event_ending_date_time}
                    desc={handleDateTime(parseInt(eventEndTime))}
                />
                {showBuy &&
                    <PrimaryButton
                        btnTitle={AppText.buy_tickets}
                        className='p-2 w-100 rounded-1  '
                        bodyClass='m-3'
                        handleOnClick={() => {
                            setSelectedEvent(item)
                            setShowBuyTicket(true)
                            
                        }}
                    />
                }
                {( show  ) ?(
                    <PrimaryButton
                        btnTitle={"Edit"}
                        className='p-2 w-100 rounded-1  '
                        bodyClass='m-3'
                        handleOnClick={() => {
                            setSelectedEvent(item)
                            setShowEdit(true)
                        }}
                    />):""
                }
            </div>
        </div>
    )
}

const EventDetailItem = ({ title = "", desc = "" }) => {
    return (
        <div className='d-flex justify-content-between '>
            <p><strong>{title}</strong></p>
            <p>{desc}</p>
        </div>
    )
}

