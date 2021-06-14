/**
 * @author Vanessa DREUX
 * @date 14/06/2021
 * @description This class implements Schedulable to execute BatchUpdateAccount class
 */
global class SchedulerUpdateAllAccounts implements Schedulable {
	global void execute(SchedulableContext info) {
		// Call BatchUpdateAccount class and schedule it through User Interface
		BatchUpdateAccount ua = new BatchUpdateAccount();
		Database.ExecuteBatch(ua, 1000);
	}
}
