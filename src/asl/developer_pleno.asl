// Agent developer_pleno in project sprint_planning_cn

/* Initial beliefs and rules */

{begin namespace(pleno, local)}
	task_difficulty(easy, 1 * math.random(.63)).
	task_difficulty(medium, 2 * math.random(.65)).
	task_difficulty(hard, 4 * math.random(.68)).
	task_difficulty(impossible, 5 * math.random(.70)).
{end}

/* Initial goals */

!register.

/* Plans */

+!register <- .df_register("developer").

+TaskID::cnp_started[source(A)]
	<- + {
		+?TaskId::points(ID, TaskDifficulty, PointsEstimate)
			: pleno::task_difficulty(TaskDifficulty, Estimate)
			<- PointsEstimate = Estimate 
	};
		.include("developer.asl", TaskID).