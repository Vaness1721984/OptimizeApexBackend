@isTest
public class SchedulerUpdateAllAccounts_Tests {
	// Dummy CRON expression: midnight on March 15.
	// Because this is a test, job executes
	// immediately after Test.stopTest()
	public static String CRON_EXP = '0 0 0 15 3 ? 2022';
	static testMethod void testPositiveScheduledJob() {
		List<AggregateResult> aggr;
		// Retrieve data set from DataFactory class
		TestFactory.createTestRecordsToUpdateAccountCAInBatch(1000, 1, 1);
		//Execute Batch
		Test.startTest();
		// Schedule the test job
		String jobId = System.schedule('ScheduledApexTest', CRON_EXP, new SchedulerUpdateAllAccounts());
		Test.stopTest();
		aggr = [SELECT SUM(Chiffre_d_affaire__c) amt FROM Account WHERE Id IN (SELECT AccountId FROM Order)];
		for (AggregateResult ar : aggr)
			System.assertEquals(500000.00, ar.get('amt'));
	}
}
