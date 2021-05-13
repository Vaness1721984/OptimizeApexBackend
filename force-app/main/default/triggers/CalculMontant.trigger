trigger CalculMontant on OrderItem(after insert, after update, after delete) {
	List<Order> ordersToUpdate = new List<Order>();

	if (Trigger.isInsert | Trigger.isUpdate) {
		for (Order ord : [
			SELECT Id, TotalAmount, ShipmentCost__c
			FROM Order
			WHERE Id IN (SELECT OrderId FROM OrderItem WHERE Id = :Trigger.new)
		]) {
			if (ord.TotalAmount > 0) {
				ord.NetAmount__c = ord.TotalAmount - ord.ShipmentCost__c;
				ordersToUpdate.add(ord);
			} else {
				ord.NetAmount__c = ord.TotalAmount;
				ordersToUpdate.add(ord);
			}
			update ordersToUpdate;
		}
	}
	if (Trigger.isDelete) {
		for (Order ords : [
			SELECT Id, TotalAmount, ShipmentCost__c, (SELECT Id FROM OrderItems WHERE Id = :Trigger.Old)
			FROM Order
		]) {
			if (ords.TotalAmount > 0) {
				ords.NetAmount__c = ords.TotalAmount - ords.ShipmentCost__c;
				ordersToUpdate.add(ords);
			} else {
				ords.NetAmount__c = ords.TotalAmount;
				ordersToUpdate.add(ords);
			}
			update ordersToUpdate;
		}
	}
}
