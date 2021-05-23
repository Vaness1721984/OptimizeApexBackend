@isTest
public class TestDataFactory {
	public static void createTestRecordsForUpdateAccountCAForInsertTrigger(
		Integer numAccts,
		Integer numOrdersPerAcct,
		Integer numOrderItemsPerOrder
	) {
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

		// Create Accounts with an Order
		List<Account> accts = new List<Account>();

		for (Integer i = 0; i < numAccts; i++) {
			Account a = new Account(Name = 'Test Account' + i);
			accts.add(a);
		}
		insert accts;

		List<Order> ords = new List<Order>();
		for (Integer j = 0; j < numAccts; j++) {
			Account acct = accts[j];
			for (Integer k = numOrdersPerAcct * j; k < numOrdersPerAcct * (j + 1); k++) {
				ords.add(
					new Order(
						AccountId = acct.Id,
						EffectiveDate = date.parse('15/11/2021'),
						ShipmentCost__c = 2,
						Pricebook2Id = pbeCustom.Pricebook2Id,
						Status = 'Draft'
					)
				);
			}
		}

		insert ords;

		// Create the order item
		List<OrderItem> oi = new List<OrderItem>();
		for (Integer l = 0; l < numOrdersPerAcct; l++) {
			Order ord = ords[l];
			for (
				Integer m = numAccts * numOrderItemsPerOrder * l; m < numAccts * numOrderItemsPerOrder * (l + 1); m++
			) {
				oi.add(
					new OrderItem(
						OrderId = ord.Id,
						Product2Id = pd1.Id,
						PricebookEntryId = pbeCustom.Id,
						UnitPrice = pbeCustom.UnitPrice,
						Quantity = 10
					)
				);
			}
		}
		insert oi;
		//Update Status on Order to "Ordered"
		List<Order> listToUpdate = new List<Order>();
		for (Order con : ords) {
			con.Status = 'Ordered';
			listToUpdate.add(con);
		}
		update listToUpdate;
	}

	public static void createTestRecordsForUpdateAccountCAForDeleteTrigger(
		Integer numAccts,
		Integer numOrdersPerAcct,
		Integer numOrderItemsPerOrder
	) {
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

		// Create Accounts with an Order
		List<Account> accts = new List<Account>();

		for (Integer i = 0; i < numAccts; i++) {
			Account a = new Account(Name = 'Test Account' + i);
			accts.add(a);
		}
		insert accts;

		List<Order> ords = new List<Order>();
		for (Integer j = 0; j < numAccts; j++) {
			Account acct = accts[j];
			for (Integer k = numOrdersPerAcct * j; k < numOrdersPerAcct * (j + 1); k++) {
				ords.add(
					new Order(
						AccountId = acct.Id,
						EffectiveDate = date.parse('15/11/2021'),
						ShipmentCost__c = 2,
						Pricebook2Id = pbeCustom.Pricebook2Id,
						Status = 'Draft'
					)
				);
			}
		}

		insert ords;

		// Create the order item
		List<OrderItem> oi = new List<OrderItem>();
		for (Integer l = 0; l < numOrdersPerAcct; l++) {
			Order ord = ords[l];
			for (
				Integer m = numAccts * numOrderItemsPerOrder * l; m < numAccts * numOrderItemsPerOrder * (l + 1); m++
			) {
				oi.add(
					new OrderItem(
						OrderId = ord.Id,
						Product2Id = pd1.Id,
						PricebookEntryId = pbeCustom.Id,
						UnitPrice = pbeCustom.UnitPrice,
						Quantity = 10
					)
				);
			}
		}
		insert oi;
		//Update Status on Order to "Ordered"
		List<Order> listToUpdate = new List<Order>();
		for (Order con : ords) {
			con.Status = 'Ordered';
			listToUpdate.add(con);
		}
		update listToUpdate;

		delete oi;
	}

	public static void createTestRecordsForCalculMontantForInsertTrigger() {
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
	}
	public static void createTestRecordsForCalculMontantForDeleteTrigger() {
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

		delete oi1;
		delete oi2;
	}

	public static void createTestRecordsToUpdateAccountCAInBatch(
		Integer numAccts,
		Integer numOrdersPerAcct,
		Integer numOrderItemsPerOrder
	) {
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

		// Create Accounts with an Order
		List<Account> accts = new List<Account>();

		for (Integer i = 0; i < numAccts; i++) {
			Account a = new Account(Name = 'Test Account' + i);
			accts.add(a);
		}
		insert accts;

		List<Order> ords = new List<Order>();
		for (Integer j = 0; j < numAccts; j++) {
			Account acct = accts[j];
			for (Integer k = numOrdersPerAcct * j; k < numOrdersPerAcct * (j + 1); k++) {
				ords.add(
					new Order(
						AccountId = acct.Id,
						EffectiveDate = date.parse('15/11/2021'),
						ShipmentCost__c = 2,
						Pricebook2Id = pbeCustom.Pricebook2Id,
						Status = 'Draft'
					)
				);
			}
		}

		insert ords;

		// Create the order item
		List<OrderItem> oi = new List<OrderItem>();
		for (Integer l = 0; l < numOrdersPerAcct; l++) {
			Order ord = ords[l];
			for (
				Integer m = numAccts * numOrderItemsPerOrder * l; m < numAccts * numOrderItemsPerOrder * (l + 1); m++
			) {
				oi.add(
					new OrderItem(
						OrderId = ord.Id,
						Product2Id = pd1.Id,
						PricebookEntryId = pbeCustom.Id,
						UnitPrice = pbeCustom.UnitPrice,
						Quantity = 10
					)
				);
			}
		}
		insert oi;
		//Update Status on Order to "Ordered"
		List<Order> listToUpdate = new List<Order>();
		for (Order con : ords) {
			con.Status = 'Ordered';
			listToUpdate.add(con);
		}
		update listToUpdate;
	}
}
