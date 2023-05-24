// Agent developer in project sprint_planning_cn

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

// some agent A asks for a point estimate of some task for some Dev
+call_for_proposal(task(ID, Difficulty))[source(product_owner)]
	<- ?points(ID, Difficulty, Points);
		.println("Proposing ", Points, " for task (", ID, ") dev => ", source(self));
		.send(product_owner, tell, ::propose(Points));
		+participating(ID).
		
+accept_estimate
	: participating(TaskID)
	<- .print("The estimate in (", this_ns, ") for task ", TaskID, " won.").


+reject_estimate
	: participating(TaskID)
	<- .print("I lost the estimate in ", this_ns, " for task ", TaskID, ".").