public class UpdateAccountCA {
	public static void UpdateAccountCA(List<Order> listOfOrders) {
		map<id, Account> updateMap = new Map<id, Account>();
		set<ID> accset = new Set<ID>();
		// List of Orders concerned by trigger
		for (Order ord : listOfOrders) {
			if (ord.AccountId != null)
				accset.add(ord.AccountId);
		}
		// Query list of orders with 'Ordered' status
		List<AggregateResult> AggregateResultList = [
			SELECT AccountId, SUM(TotalAmount) amt
			FROM Order
			WHERE Status = 'Ordered' AND AccountId IN :accset
			GROUP BY AccountId
		];
		// For loop that updates Chiffre_d_affaire__c on each account with aggregation of TotalAmount from Orders
		for (AggregateResult aggr : AggregateResultList) {
			Account acc = new Account();
			acc.Id = (id) aggr.get('AccountId');
			acc.Chiffre_d_affaire__c = (decimal) aggr.get('amt');
			updateMap.put(acc.Id, acc);
		}

		update updateMap.values();
	}
}
