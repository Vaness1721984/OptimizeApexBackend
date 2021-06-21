@isTest
private class NetAmountCalculation_Tests {
	static testMethod void testPositiveUpdateNetAmountonOrderAfterInsert() {
		List<AggregateResult> aggr;
		// Retrieve data set from DataFactory class
		TestFactory.createTestRecordsForNetAmountCalculationForInsertTrigger();

		// Retrieve the value in NetAmount__c field
		Test.startTest();
		aggr = [SELECT SUM(NetAmount__c) netAmt FROM Order];
		Test.stopTest();
		// Verify that the trigger correctly updated NetAmount__c field
		for (AggregateResult ar : aggr)
			System.assertequals(1498, ar.get('netAmt'));
	}
	static testMethod void testPositiveUpdateNetAmountonOrderAfterDelete() {
		List<AggregateResult> aggr;
		// Retrieve data set from DataFactory class
		TestFactory.createTestRecordsForNetAmountCalculationForDeleteTrigger();

		// Retrieve the value in NetAmount__c field
		Test.startTest();
		aggr = [SELECT SUM(NetAmount__c) netAmt FROM Order];
		Test.stopTest();
		// Verify that the trigger correctly updated NetAmount__c field
		for (AggregateResult ar : aggr)
			System.assertequals(0, ar.get('netAmt'));
	}
}
