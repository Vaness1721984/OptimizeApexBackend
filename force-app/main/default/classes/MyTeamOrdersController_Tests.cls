@isTest
public class MyTeamOrdersController_Tests {
	@isTest
	static void PermissionSetTest_Negative() {
		TestFactory.createTestRecordsForMyTeamOrdersController(1, 2, 2);

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
			List<AggregateResult> aggr;
			Test.startTest();
			aggr = [SELECT SUM(TotalAmount) total FROM Order];
			Test.stopTest();
			for (AggregateResult ar : aggr)
				system.assertEquals(2000, ar.get('total'));
		}
	}
}
