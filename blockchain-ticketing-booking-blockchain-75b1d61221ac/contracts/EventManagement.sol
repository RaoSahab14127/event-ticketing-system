// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract EventManagement {
    // website owner public address
    // Struct to represent service provider information
    struct ServiceProviderInfo {
        address payable wallet;
        uint256 totalAccumulatedFee;
        // percentage cut given to service provider
        uint256 middlemanCutPercentage;
    }
    
    // Service provider information
    ServiceProviderInfo public serviceProvider;
    
    // counter to keep track of total events
    uint256 totalEvents = 0;

    // Struct to represent event information
    struct Event {
        uint256 id;
        // string img_url;
        // string title;
        // string description;
        bool is_active;
        uint256 ticketCount;
        uint256 ticket_price;
        uint256 eventStartTime;
        uint256 eventEndTime;
        address payable organizer; // Organizer's wallet address
        address[] participants; // List of addresses of people who bought tickets
    }

    // ===================== EVENTS =====================

    // Mapping to store events by their ID
    mapping(uint256 => Event) public events;

    // Event to notify when a new event is added
    event EventAdded(uint256 eventId);

    // Event to notify when any event is updated
    event EventUpdated(uint256 eventId);

    // Event to notify when the service provider gets his cut
    event EventCutGivenToServiceProvider(uint256 eventId, uint256 amount);

    // Event to notify when a payment is received
    event PaymentReceived(uint256 eventId, address payer, uint256 amount);

    // Event to notify the addition oftickets ot an event
    event TicketsAdded(uint256 eventId, uint ticketsAdded);

    // ===================== MODIFIERS =====================

    // Modifier to check if the event is still active based on datetime
    modifier onlyActiveEvent(uint256 _eventId) {
        require(events[_eventId].is_active, "Event is not active");
        require(
            block.timestamp < events[_eventId].eventEndTime,
            "Event datetime has passed"
        );
        _;
    }

    // ===================== METHODS =====================

    constructor() {
        // Set the deployer as the service provider
        serviceProvider = ServiceProviderInfo({
            wallet: payable(msg.sender),
            totalAccumulatedFee: 0,
            middlemanCutPercentage: 20 // 20% cut given to middleman
        });

        // adding sample event at index 0
        // Event storage newEvent0 = events[0];
        // newEvent0.id = 0;
        // newEvent0.img_url = "https://trufflesuite.com/assets/logo.png";
        // newEvent0.title = "Web3 Service Start";
        // newEvent0.description = "Commemoration Event";
        // newEvent0.is_active = true;
        // newEvent0.ticket_price = 0;
        // newEvent0.ticketCount = 0;
        // newEvent0.organizer = payable(msg.sender);
        // newEvent0.eventStartTime = 0;
        // newEvent0.eventEndTime = 999999999999;

        // emit EventAdded(0);

        // // adding sample event at index 1
        // Event storage newEvent1 = events[1];
        // newEvent1.id = 1;
        // newEvent1.img_url = "https://media-cdn.tripadvisor.com/media/photo-s/09/97/8c/27/castle-rock-trading-post.jpg";
        // newEvent1.title = "Enchanted Jazz Night";
        // newEvent1.description = "Immerse yourself in the magical world of jazz under the stars. Join us for a night of soulful tunes and rhythmic beats.";
        // newEvent1.is_active = false;
        // newEvent1.ticket_price = 200000;
        // newEvent1.ticketCount = 0;
        // newEvent1.organizer = payable(msg.sender);
        // newEvent1.eventStartTime = 1701260853;
        // newEvent1.eventEndTime = 1701260953;

        // emit EventAdded(1);

        // totalEvents++;

        // // adding sample event at index 2
        // Event storage newEvent2 = events[2];
        // newEvent2.id = 2;
        // newEvent2.img_url = "https://technext24.com/wp-content/uploads/2020/10/events.jpeg";
        // newEvent2.title = "Tech Innovators Summit";
        // newEvent2.description = "Explore the latest trends and innovations in the tech industry. Join top experts and visionaries for insightful discussions and networking.";
        // newEvent2.is_active = true;
        // newEvent2.ticket_price = 250000;
        // newEvent2.ticketCount = 150;
        // newEvent2.organizer = payable(msg.sender);
        // newEvent2.eventStartTime = 1701260953;
        // newEvent2.eventEndTime = 1701261053;

        // emit EventAdded(2);

        // totalEvents++;
        
        // // adding sample event at index 3
        // Event storage newEvent3 = events[3];
        // newEvent3.id = 3;
        // newEvent3.img_url = "https://artzealous.com/wp-content/uploads/2018/10/Screen-Shot-2018-10-02-at-4.21.26-PM-e1538511906575.png";
        // newEvent3.title = "Whimsical Art Gala";
        // newEvent3.description = "Step into a world of whimsy and wonder at our art gala. Marvel at breathtaking artworks and engage with the creative minds behind them.";
        // newEvent3.is_active = true;
        // newEvent3.ticket_price = 108000;
        // newEvent3.ticketCount = 120;
        // newEvent3.organizer = payable(msg.sender);
        // newEvent3.eventStartTime = 1701261053;
        // newEvent3.eventEndTime = 1701261153;

        // emit EventAdded(3);

        // totalEvents++;

        // // adding sample event at index 4
        // Event storage newEvent4 = events[4];
        // newEvent4.id = 4;
        // newEvent4.img_url = "https://i.pinimg.com/originals/be/bd/64/bebd641805f000ba0763d167020e1262.jpg";
        // newEvent4.title = "Hidden Gem Food Tasting";
        // newEvent4.description = "Embark on a culinary journey to discover hidden gems in the world of flavors. Savor delectable dishes crafted by talented chefs.";
        // newEvent4.is_active = false;
        // newEvent4.ticket_price = 150000;
        // newEvent4.ticketCount = 0;
        // newEvent4.organizer = payable(msg.sender);
        // newEvent4.eventStartTime = 1701261153;
        // newEvent4.eventEndTime = 1701261253;

        // emit EventAdded(4);

        // totalEvents++;

        // // // adding sample event at index 5
        // Event storage newEvent5 = events[5];
        // newEvent5.id = 5;
        // newEvent5.img_url = "https://www.impactnational.com.au/wp-content/uploads/2022/11/tradeshow-1024x683-2.jpg";
        // newEvent5.title = "Epic Adventure Expo";
        // newEvent5.description = "Calling all thrill-seekers! Join us for an epic adventure expo featuring adrenaline-pumping activities and the latest outdoor gear.";
        // newEvent5.is_active = true;
        // newEvent5.ticket_price = 0;
        // newEvent5.ticketCount = 300000;
        // newEvent5.organizer = payable(msg.sender);
        // newEvent5.eventStartTime = 1701261253;
        // newEvent5.eventEndTime = 1701261353;

        // emit EventAdded(5);

        // totalEvents++;
    }

    // Function to check and update the status of events
    function setEventStatus(uint256 _eventId, bool _activeStatus)
        external
        onlyActiveEvent(_eventId)
    {
        events[_eventId].is_active = _activeStatus;
    }

    // Function to add a new event
    function addEvent(
        uint256 _id,
        // string calldata _img_url,
        // string calldata _title,
        // string calldata _description,
        uint256 _ticketCount,
        bool _is_active,
        uint256 _ticket_price,
        uint256 _eventEndTime
    ) external {
        require(msg.sender != address(0), "Invalid event organizer address");

        Event storage newEvent = events[_id];
        newEvent.id = _id;
        // newEvent.img_url = _img_url;
        // newEvent.title = _title;
        // newEvent.description = _description;
        newEvent.is_active = _is_active;
        newEvent.ticket_price = _ticket_price;
        newEvent.ticketCount = _ticketCount;
        newEvent.organizer = payable(msg.sender);
        newEvent.eventStartTime = this.getTodayUnixTimestamp();
        newEvent.eventEndTime = _eventEndTime;

        totalEvents++;

        emit EventAdded(_id);
    }

    // add tickets
    function addTickets(uint _eventId, uint ticketsToAdd) 
        external onlyActiveEvent(_eventId) 
    {
        Event storage targetEvent = events[_eventId];
        
        // Ensure that the organizer is the one calling this function
        require(msg.sender == targetEvent.organizer, "Only the event organizer can add tickets");

        // Update the ticket count
        targetEvent.ticketCount += ticketsToAdd;

        // Emit an event to notify that tickets have been added
        emit TicketsAdded(_eventId, ticketsToAdd);
    }

    // Function to allow users to pay for a specific event
    function payForEvent(uint256 _eventId) external payable {
        Event storage paidEvent = events[_eventId];
        require(paidEvent.is_active, "Event is not active");
        require(
            msg.value == paidEvent.ticket_price,
            "Incorrect payment amount"
        );


        // calculate the percentage share on the submitted amount
        uint256 organizerCut = calculateOrganizerFee(msg.value);
        uint256 serviceProviderCut = calculateMiddlemanFee(msg.value);

        // Transfer funds to the organizer
        paidEvent.organizer.transfer(organizerCut);

        // Emit event to notify payment received
        emit PaymentReceived(_eventId, paidEvent.organizer, organizerCut);

        // Transfer funds to the service provider
        serviceProvider.wallet.transfer(serviceProviderCut);

        // create an event for giving service provider his cut
        emit EventCutGivenToServiceProvider(_eventId, serviceProviderCut);

        serviceProvider.totalAccumulatedFee += calculateMiddlemanFee(msg.value);

        // Add the participant to the list
        paidEvent.participants.push(msg.sender);

        // Decrease the ticket count by 1
        require(paidEvent.ticketCount > 0, "No more tickets available");
        paidEvent.ticketCount--;

        // Check if the event is sold out and update its status
        if (paidEvent.ticketCount == 0) {
            paidEvent.is_active = false;
        }
    }

    // ===================== GETTERS =====================

    // Function to get event details by ID
    function getEventDetails(uint256 _id)
        external
        view
        returns (
            // string memory img_url,
            // string memory title,
            // string memory description,
            bool is_active,
            uint256 ticketCount,
            uint256 ticket_price,
            uint256 eventStartTime,
            uint256 eventEndTime,
            address payable organizer
        )
    {
        Event storage queriedEvent = events[_id];
        return (
            // queriedEvent.img_url,
            // queriedEvent.title,
            // queriedEvent.description,
            queriedEvent.is_active,
            queriedEvent.ticketCount,
            queriedEvent.ticket_price,
            queriedEvent.eventStartTime,
            queriedEvent.eventEndTime,
            queriedEvent.organizer
        );
    }

    // get midle man's wallet address
    function getServiceProviderWallet()
        external
        view
        returns (address payable)
    {
        return serviceProvider.wallet;
    }

    // get latest event id
    function getLatestEventId() external view returns (uint256 _id) {
        return totalEvents;
    }

    // get next available event id
    function getNextAvailableEventId() external view returns (uint256 _id) {
        return totalEvents + 1;
    }

    function getServiceProviderTotalAccumulatedFee()
        internal
        view
        returns (uint256)
    {
        return serviceProvider.totalAccumulatedFee;
    }

    // ===================== SETTERS =====================

    // updates the percentage cut of the middleman
    function setMiddlemanFee(uint256 _percentage) external  {
        serviceProvider.middlemanCutPercentage = _percentage;
    }

    // Function to update event details
    function updateEvent(
        uint256 _id,
        // string calldata _img_url,
        // string calldata _title,
        // string calldata _description,
        bool _is_active,
        uint256 _ticket_price,
        uint256 _eventStartTime,
        uint256 _eventEndTime
    ) external {
        Event storage updatedEvent = events[_id];
        // updatedEvent.img_url = _img_url;
        // updatedEvent.title = _title;
        // updatedEvent.description = _description;
        updatedEvent.is_active = _is_active;
        updatedEvent.ticket_price = _ticket_price;
        updatedEvent.eventEndTime = _eventEndTime;
        updatedEvent.eventStartTime = _eventStartTime;

        emit EventUpdated(_id);
    }

    function setEventStartTime(uint256 _eventId, uint256 _eventStartDate)
        external
        onlyActiveEvent(_eventId)
        returns (bool)
    {
        events[_eventId].eventStartTime = _eventStartDate;
        return true;
    }
    
    function setEventEndTime(uint256 _eventId, uint256 _eventEndDate)
        external
        onlyActiveEvent(_eventId)
        returns (bool)
    {
        events[_eventId].eventEndTime = _eventEndDate;
        return true;
    }
    
    // function setEventImgUrl(uint256 _eventId, string memory _eventImgUrl)
    //     external
    //     onlyActiveEvent(_eventId)
    //     returns (bool)
    // {
    //     events[_eventId].img_url = _eventImgUrl;
    //     return true;
    // }

    // function setEventTitle(uint256 _eventId, string memory _eventTitle)
    //     external
    //     onlyActiveEvent(_eventId)
    //     returns (bool)
    // {
    //     events[_eventId].title = _eventTitle;
    //     return true;
    // }

    // function setEventDescription(uint256 _eventId, string memory _eventDescription)
    //     external
    //     onlyActiveEvent(_eventId)
    //     returns (bool)
    // {
    //     events[_eventId].description = _eventDescription;
    //     return true;
    // }
    
    function setEventTicketPrice(uint256 _eventId, uint256 _eventTicketPrice)
        external
        onlyActiveEvent(_eventId)
        returns (bool)
    {
        events[_eventId].ticket_price = _eventTicketPrice;
        return true;
    }

    // ===================== HELPERS =====================

    // calculates middle man's fee
    function calculateMiddlemanFee(uint256 payment_amount)
        internal
        view
        returns (uint256)
    {
        return payment_amount / (100 / serviceProvider.middlemanCutPercentage);
    }

    // calculate event organizer's fee
    function calculateOrganizerFee(uint256 payment_amount)
        internal
        view
        returns (uint256)
    {
        uint256 middlemanFee = calculateMiddlemanFee(payment_amount);
        return payment_amount - middlemanFee;
    }

    // get account's current balance
    function getAccountBalance(address _account) public view returns (uint256) {
        return _account.balance;
    }

    // Solidity code to get today's datetime in Unix timestamp format
    function getTodayUnixTimestamp() public view returns (uint256) {
        // Get the current timestamp in seconds
        return block.timestamp;
    }
}
