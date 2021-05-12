trigger CalculMontant on OrderItem(after insert, after update, after delete) {
	if (Trigger.isInsert | Trigger.isUpdate) {
		List<Order> relatedOrders = [
			SELECT Id, TotalAmount, ShipmentCost__c, (SELECT Id FROM OrderItems WHERE Id = :Trigger.New)
			FROM Order
		];
		List<Order> ordersToUpdate = new List<Order>();

		for (Order o : relatedOrders) {
			if (o.TotalAmount > 0) {
				o.NetAmount__c = o.TotalAmount - o.ShipmentCost__c;
				ordersToUpdate.add(o);
			} else {
				o.NetAmount__c = o.TotalAmount;
				ordersToUpdate.add(o);
			}
			update ordersToUpdate;
		}
	}
	if (Trigger.isDelete) {
		List<Order> relatedOrders = [
			SELECT Id, TotalAmount, ShipmentCost__c, (SELECT Id FROM OrderItems WHERE Id = :Trigger.Old)
			FROM Order
		];
		List<Order> ordersToUpdate = new List<Order>();

		for (Order o : relatedOrders) {
			if (o.TotalAmount > 0) {
				o.NetAmount__c = o.TotalAmount - o.ShipmentCost__c;
				ordersToUpdate.add(o);
			} else {
				o.NetAmount__c = o.TotalAmount;
				ordersToUpdate.add(o);
			}
			update ordersToUpdate;
		}
	}
}
