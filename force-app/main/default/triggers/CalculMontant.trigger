trigger CalculMontant on OrderItem(after insert, after update, after delete) {
	map<id, Order> updateMap = new Map<id, Order>();
	set<ID> ordset = new Set<ID>();

	if (Trigger.isInsert | Trigger.isUpdate) {
		for (OrderItem ord : Trigger.new) {
			if (ord.OrderId != null)
				ordset.add(ord.OrderId);
		}
	}
	if (Trigger.isDelete) {
		for (OrderItem ords : Trigger.old) {
			if (ords.OrderId != null)
				ordset.add(ords.OrderId);
		}
	}
	List<OrderItem> ResultList = [
		SELECT OrderId, Order.TotalAmount, Order.ShipmentCost__c
		FROM OrderItem
		WHERE OrderId IN :ordset
	];

	if (ResultList != null && ResultList.size() > 0) {
		for (OrderItem res : ResultList) {
			Order orde = new Order();
			orde.Id = (id) res.get('OrderId');
			orde.NetAmount__c = res.Order.TotalAmount - res.Order.ShipmentCost__c;
			updateMap.put(orde.Id, orde);
		}
	} else {
		for (id idSet : ordset) {
			Order orde = new Order();
			orde.Id = idSet;
			orde.NetAmount__c = 0;
			updateMap.put(orde.Id, orde);
		}
	}
	update updateMap.values();
}
