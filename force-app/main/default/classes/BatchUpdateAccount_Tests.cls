@isTest
public class BatchUpdateAccount_Tests {
	@isTest
	static void testUpdateCAwith1000AccountsInBatch() {
		List<AggregateResult> aggr;
		// Retrieve data set from DataFactory class
		TestFactory.createTestRecordsToUpdateAccountCAInBatch(1, 200, 1);
		// Execute Batch
		Test.startTest();
		BatchUpdateAccount ua = new BatchUpdateAccount();
		Id batchId = Database.executeBatch(ua, 1000);
		aggr = [SELECT SUM(Chiffre_d_affaire__c) amt FROM Account WHERE Id IN (SELECT AccountId FROM Order)];
		Test.stopTest();
		// After the testing stops, assert records were updated properly
		for (AggregateResult ar : aggr)
			System.assertEquals(100000.00, ar.get('amt'));
	}
}
