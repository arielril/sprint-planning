// Agent developer in project sprint_planning_cn

/* Initial beliefs and rules */

{begin namespace(junior, local)}
	task_difficulty(easy, 1 * math.random(.80)).
	task_difficulty(medium, 3 * math.random(.87)).
	task_difficulty(hard, 4 * math.random(.90)).
	task_difficulty(impossible, 6 * math.random(.97)).
{end}


/* Initial goals */

!register.

/* Plans */

+!register <- .df_register("developer").

+TaskID::cnp_started[source(A)]
	<- + {
		+?TaskID::points(ID, TaskDifficulty, PointsEstimate)
			: junior::task_difficulty(TaskDifficulty, Estimate)
			<- PointsEstimate = Estimate 
	};
		.include("developer.asl", TaskID).
