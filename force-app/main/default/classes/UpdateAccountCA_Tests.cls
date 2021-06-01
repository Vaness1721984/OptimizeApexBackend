@isTest
public class UpdateAccountCA_Tests {
	@isTest
	static void testUpdateCAwith200AccountsAfterInsert() {
		List<AggregateResult> aggr;
		// Retrieve data set from DataFactory class
		TestFactory.createTestRecordsForUpdateAccountCAForInsertTrigger(200, 2, 3);

		// Retrieve the value in Chiffre_d_affaire__c field
		Test.startTest();
		aggr = [SELECT SUM(Chiffre_d_affaire__c) amt FROM Account WHERE Id IN (SELECT AccountId FROM Order)];
		Test.stopTest();
		//Verify that the trigger correctly updated Chiffre_d_affaire__c field
		for (AggregateResult ar : aggr)
			System.assertEquals(600000, ar.get('amt'));
	}
	@isTest
	static void testUpdateCAwith200AccountsAfterDelete() {
		List<AggregateResult> aggr;
		// Retrieve data set from DataFactory class
		TestFactory.createTestRecordsForUpdateAccountCAForDeleteTrigger(200, 2, 3);

		// Retrieve the value in Chiffre_d_affaire__c field
		Test.startTest();
		aggr = [SELECT SUM(Chiffre_d_affaire__c) amt FROM Account WHERE Id IN (SELECT AccountId FROM Order)];
		Test.stopTest();
		//Verify that the trigger correctly updated Chiffre_d_affaire__c field
		for (AggregateResult ar : aggr)
			System.assertEquals(0, ar.get('amt'));
	}

	@isTest
	static void testAccountCreation() {
		List<Account> accts;
		// Retrieve data set from DataFactory class
		TestFactory.createTestRecordsForUpdateAccountCAForInsertTrigger(10, 2, 4);
		//Retrieve the list of IDs for Account
		Test.startTest();
		accts = [SELECT ID FROM Account];
		Test.stopTest();
		// Verify that the correct number of accounts has been created
		System.assertEquals(10, accts.size());
	}

	@isTest
	static void testOrderCreation() {
		List<Order> ords;
		// Retrieve data set from DataFactory class
		TestFactory.createTestRecordsForUpdateAccountCAForInsertTrigger(10, 2, 4);
		//Retrieve the list of IDs for Order
		Test.startTest();
		ords = [SELECT ID FROM Order];
		Test.stopTest();
		// Verify that the correct number of orders has been created
		System.assertEquals(20, ords.size());
	}

	@isTest
	static void testOrderItemCreation() {
		List<OrderItem> orits;
		// Retrieve data set from DataFactory class
		TestFactory.createTestRecordsForUpdateAccountCAForInsertTrigger(10, 2, 4);
		//Retrieve the list of IDs for Order Item
		Test.startTest();
		orits = [SELECT ID FROM OrderItem];
		Test.stopTest();
		// Verify that the correct number of order items has been created
		System.assertEquals(80, orits.size());
	}
}
