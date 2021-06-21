/**
 * @author Vanessa DREUX
 * @date 14/06/2021
 * @description Update Chiffre_d_affaire__c field of Accounts with an aggregation of TotalAmount field from Orders
 * @param List A list of Orders that should be concerned by the update of Chiffre_d_affaire__c field
 * @param Map A map of Accounts with their Chiffre_d_affaire__c field set with an aggregation of TotalAmount field
 */

public class UpdateAccountCA {
	public static void updateAccountCA(List<Order> listOfOrders) {
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
