global class SchedulerUpdateAllAccounts implements Schedulable {
	global void execute(SchedulableContext info) {
		BatchUpdateAccount ua = new BatchUpdateAccount();
		Database.ExecuteBatch(ua, 1000);
	}
}
