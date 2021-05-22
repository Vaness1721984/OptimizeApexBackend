@isTest
private class TestCalculMontant {
	static testMethod void testPositiveUpdateNetAmountonOrderAfterInsert() {
		List<AggregateResult> aggr;

		TestDataFactory.createTestRecordsForCalculMontantForInsertTrigger();

		// Retrieve the value in Net Amount field
		Test.startTest();
		aggr = [SELECT SUM(NetAmount__c) netAmt FROM Order];
		Test.stopTest();
		//Test that the trigger correctly updated the CA
		for (AggregateResult ar : aggr)
			System.assertequals(1498, ar.get('netAmt'));
	}
	static testMethod void testPositiveUpdateNetAmountonOrderAfterDelete() {
		List<AggregateResult> aggr;

		TestDataFactory.createTestRecordsForCalculMontantForDeleteTrigger();

		// Retrieve the value in Net Amount field
		Test.startTest();
		aggr = [SELECT SUM(NetAmount__c) netAmt FROM Order];
		Test.stopTest();
		//Test that the trigger correctly updated the CA
		for (AggregateResult ar : aggr)
			System.assertequals(0, ar.get('netAmt'));
	}
}
