import React from 'react'
import { AppConstants, AppText, handleDateTime } from '../../helpers/AppConstants'
import PrimaryButton from './PrimaryButton'

export default function Card({ item, setShowBuyTicket, setSelectedEvent, showBuy = true }) {
    const { description, eventEndTime, eventStartTime, img_url, ticketCount, ticket_price, title } = item

    const handleImage = (event_image) => {
        if (event_image.includes("http")) {
            return event_image
        } else {
            return AppConstants.localImagesFolder + event_image
        }
    }
    return (
        <div className="col-lg-4 col-md-6">
            <div className="hotel">
                <div className="hotel-img">
                    <img
                        src={handleImage(img_url)}
                        alt="Hotel 1"
                        className="img-fluid"
                    />
                </div>
                <h3><a href="#">{title}</a></h3>
                {/* <div className="stars">
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                    <i className="fa fa-star"></i>
                </div> */}
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
