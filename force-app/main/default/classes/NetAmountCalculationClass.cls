/**
 * @author Vanessa DREUX
 * @date 14/06/2021
 * @description Update Net_Amount__c field of Orders with a formula
 * @param List A list of OrderItems that should be concerned by the update of Net_Amount__c field
 * @param Map A map of Orders with their Net_Amount__c field set with formula if list is not empty
 * @param Map A map of Orders with their Net_Amount__c field set with 0 if list is empty
 */
public class NetAmountCalculationClass {
	public static void updateNetAmountOnOrder(List<OrderItem> listOfOrderItems) {
		map<id, Order> updateMap = new Map<id, Order>();
		set<ID> ordset = new Set<ID>();
		// List of OrderItem concerned by trigger
		for (OrderItem ord : listOfOrderItems) {
			if (ord.OrderId != null)
				ordset.add(ord.OrderId);
		}
		// Query list of OrderItems
		List<OrderItem> ResultList = [
			SELECT OrderId, Order.TotalAmount, Order.ShipmentCost__c
			FROM OrderItem
			WHERE OrderId IN :ordset
		];
		// Condition if list of OrderItems is not empty : NetAmount__c is equal to TotalAmount - ShipmentCost__c
		if (ResultList != null && ResultList.size() > 0) {
			for (OrderItem res : ResultList) {
				Order orde = new Order();
				orde.Id = (id) res.get('OrderId');
				orde.NetAmount__c = res.Order.TotalAmount - res.Order.ShipmentCost__c;
				updateMap.put(orde.Id, orde);
			}
			// Condition if list of OrderItems is empty : NetAmount__c is equal to 0
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
}
