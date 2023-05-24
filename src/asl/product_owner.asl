// Agent product_owner in project sprint_planning_cn

/* Initial beliefs and rules */

/* Initial goals */

!start([
	task(easy1, easy),
	task(easy2, easy),
	task(easy3, easy),
	task(easy4, easy),
	task(easy5, easy),
	
	task(medium1, medium),
	task(medium2, medium),
	task(medium3, medium),
	task(medium4, medium),
	
	task(hard1, hard),
	task(hard2, hard),
	
	task(impossible1, impossible)
]).

/* Plans */

+!start([]).

@sendTheTasksForTheTeam
+!start([task(ID, Difficulty)|Rest])
	// Load the initiator inside a namespace of the task
	<- .include("initiator.asl", ID);

		// add the winner plan for each task
		+{ 
			+ID::winner(WinnerOffer, WinnerDev) 
				<- .print("The winner estimate for task ", ID, " is ", WinnerOffer, " points from ", WinnerDev)
		};
		
		!!ID::startCNP(task(ID, Difficulty));
		!start(Rest).

