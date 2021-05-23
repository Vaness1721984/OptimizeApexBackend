@isTest
public class TestUpdateAccount {
	@isTest
	static void testUpdateCAwith1000AccountsInBatch() {
		List<AggregateResult> aggr;
		// Retrieve data set from DataFactory class
		TestDataFactory.createTestRecordsToUpdateAccountCAInBatch(1000, 1, 1);
		//Execute Batch
		Test.startTest();
		UpdateAccount ua = new UpdateAccount();
		Id batchId = Database.executeBatch(ua, 1000);
		aggr = [SELECT SUM(Chiffre_d_affaire__c) amt FROM Account WHERE Id IN (SELECT AccountId FROM Order)];
		Test.stopTest();
		// after the testing stops, assert records were updated properly
		for (AggregateResult ar : aggr)
			System.assertEquals(500000.00, ar.get('amt'));
	}
}
