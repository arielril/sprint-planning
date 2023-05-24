// Agent developer_senior in project sprint_planning_cn

/* Initial beliefs and rules */

{begin namespace(senior, local)}
	task_difficulty(easy, 1 * math.random(.10)).
	task_difficulty(medium, 1 * math.random(.20)).
	task_difficulty(hard, 3 * math.random(.33)).
	task_difficulty(impossible, 4 * math.random(.35)).
{end}

/* Initial goals */

!register.

/* Plans */

+!register <- .df_register("developer").

+TaskID::cnp_started[source(A)]
	<- + {
		+?N::points(ID, TaskDifficulty, PointsEstimate)
			: senior::task_difficulty(TaskDifficulty, Estimate)
			<- PointsEstimate = Estimate 
	};
		.include("developer.asl", TaskID).