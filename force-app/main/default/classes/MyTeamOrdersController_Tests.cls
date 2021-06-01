@isTest
public class MyTeamOrdersController_Tests {
	@isTest
	static void PermissionSetTest_Negative() {
		// Retrieve data set from DataFactory class
		TestFactory.createTestRecordsForMyTeamOrdersController(1, 2, 2);
		// Creation of a new user with sharing set to private on Account
		User u = new User(
			ProfileId = [SELECT Id FROM Profile WHERE Name = 'Sales']
			.Id,
			LastName = 'Commercial',
			FirstName = 'USA',
			Email = 'Commercial_USA1@fasha.com',
			UserName = 'Commercial_usa-crm1@fasha.com',
			Alias = 'alias',
			TimeZoneSidKey = 'Europe/Paris',
			EmailEncodingKey = 'UTF-8',
			LanguageLocaleKey = 'en_US',
			LocaleSidKey = 'en_US'
		);

		System.runAs(u) {
			List<Account> accts;
			// Retrieve the list of Accounts
			Test.startTest();
			accts = [SELECT Id FROM Account];
			Test.stopTest();
			// Verify that no account can be seen
			system.assertEquals(0, accts.size());
		}
	}
	@isTest
	static void PermissionSetTest_Positive() {
		// Retrieve data set from DataFactory class
		TestFactory.createTestRecordsForMyTeamOrdersController(1, 2, 2);
		List<AggregateResult> aggr;
		// Retrieve the TotalAmount on Orders
		Test.startTest();
		aggr = [SELECT SUM(TotalAmount) total FROM Order];
		Test.stopTest();
		// Verify that TotalAmount is correct
		for (AggregateResult ar : aggr)
			system.assertEquals(2000, ar.get('total'));
	}
}
