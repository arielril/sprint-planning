// Agent initiator in project sprint_planning_cn

{ namespace(priv,local) } // Forward definition of private namespace (identified by 'priv')

//prefix :: forces a term to be considered in the abstract namespace

priv::all_proposals_received
    :-  number_developers(NUMDEV) &
        .count(::propose(_)[source(_)], NUMOFFER) &
        .count(::refuse[source(_)], NUMREFUSALS) &
        NUMDEV = NUMOFFER + NUMREFUSALS. // participants = offers + refusals

// starts a CNP
@p1
+!startCNP(task(ID, Difficulty))
    <-  .print("Waiting developers for task ID (", ID, ") in ", this_ns ," ... ");
        .wait(1000); // wait (1s) participants register
        
        // broadcast the message that the CNP started
        .broadcast(tell, ::cnp_started);
        
        // wait participants to prepare themselves for the CNP
        .wait(1000); 

		// remember the state of the CNP
        +priv::state(propose); 
        
        .print("Sending Call For Proposal for task ", ID, " to all developers");
        
        // tell the developers to send their proposals
       	.broadcast(tell, ::call_for_proposal(task(ID, Difficulty)));
        
        // wait until all proposals are received for a maximum of 5 secs
        .wait(priv::all_proposals_received, 5000, _);
        !priv::contract(this_ns).

// to let the agent to query the current state of the CNP
@p2 +?cnp_state(S) <- ?priv::state(S).
@p3 +?cnp_state(none).

{begin namespace(priv)}
    // .intend (g) is true if the agent is currently intending !g
    +!contract(TaskID) 
    	: state(propose) & not .intend(::contract(_))
        <-  -+state(contract); // updates the state of CNP
            .findall(offer(Points, Dev), TaskID::propose(Points)[source(Dev)], LOffers);
            .print("Offers in CNP taking place in ", TaskID, " are ", LOffers);
            LOffers \== []; // constraint the plan execution to at least one offer
            
            // sort the result list and get the median value as result
            .sort(LOffers, LOfferSorted);
            .nth(.length(LOfferSorted)/2, LOfferSorted, offer(WinnerOffer, WinnerDev));
            
            // call the winner
            +TaskID::winner(WinnerOffer, WinnerDev);
            !announce_result(TaskID, LOffers);
            -+state(finished).

    // nothing todo, the current phase is not propose
    +!contract(_).
    -!contract(TaskID)
        <- .print("CNP taking place in ", TaskID, " has failed! No proposals");
           -+state(finished).

    +!announce_result(_,[]).

    // award contract to the winner
    +!announce_result (TaskID, [offer(Offer,Dev)|Tail]) 
       : Ns::winner(Offer, Dev)
       <- .send(Dev, tell, TaskID::accept_estimate); // notify the winner
          !announce_result(TaskID,Tail).
          
    // announce to others
    +!announce_result(TaskID, [offer(Offer,Dev)|Tail])
       <- .send(Dev, tell, TaskID::reject_estimate);
          !announce_result(TaskID, Tail).
{end}
