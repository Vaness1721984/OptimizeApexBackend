@isTest
private class TestCalculMontant {
	static testMethod void testPositiveUpdateNetAmountonOrder() {
		// Test data setup
		// Create a product
		Product2 pd1 = new Product2(
			Name = 'Chemise Verte longue XYX',
			Family = 'Chemise',
			ProductCode = 'ABC123',
			IsActive = true
		);
		insert pd1;

		//Create the PricebookEntry Standard
		PricebookEntry pbeStandard = new PricebookEntry(
			Pricebook2Id = Test.getStandardPricebookId(),
			Product2Id = pd1.Id,
			UnitPrice = 50,
			IsActive = true
		);
		insert pbeStandard;

		// Create Price Book
		PriceBook2 pb = new Pricebook2(Name = 'Standard Price Book', IsActive = true);
		insert pb;

		//Create the PricebookEntry Custom
		PricebookEntry pbeCustom = new PricebookEntry(
			Pricebook2Id = pb.Id,
			Product2Id = pd1.Id,
			UnitPrice = 50,
			IsActive = true
		);
		insert pbeCustom;

		// Create an Account with an Order
		Account acc1 = new Account(Name = 'Test Account 1');
		insert acc1;
		Order o1 = new Order(
			AccountId = acc1.Id,
			EffectiveDate = date.parse('15/11/2021'),
			ShipmentCost__c = 2,
			Pricebook2Id = pbeCustom.Pricebook2Id,
			Status = 'Draft'
		);
		insert o1;

		// Create the order items
		OrderItem oi1 = new OrderItem(
			OrderId = o1.Id,
			Product2Id = pd1.Id,
			PricebookEntryId = pbeCustom.Id,
			UnitPrice = pbeCustom.UnitPrice,
			Quantity = 10
		);
		insert oi1;
		OrderItem oi2 = new OrderItem(
			OrderId = o1.Id,
			Product2Id = pd1.Id,
			PricebookEntryId = pbeCustom.Id,
			UnitPrice = pbeCustom.UnitPrice,
			Quantity = 20
		);
		insert oi2;

		// Retrieve the value in Net Amount field
		o1 = [SELECT NetAmount__c FROM Order WHERE Id = :o1.Id];

		//Test that the trigger correctly updated the CA
		System.assertequals(1498, o1.NetAmount__c);
	}
}
