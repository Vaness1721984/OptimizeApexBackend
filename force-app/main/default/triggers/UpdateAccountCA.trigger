trigger UpdateAccountCA on Order(after insert, after update, after delete) {
	map<id, Account> updateMap = new Map<id, Account>();
	set<ID> accset = new Set<ID>();

	if (Trigger.isInsert | Trigger.isUpdate) {
		for (Order ord : Trigger.new) {
			if (ord.AccountId != null)
				accset.add(ord.AccountId);
		}
	}
	if (Trigger.isDelete) {
		for (Order ords : Trigger.old) {
			if (ords.AccountId != null)
				accset.add(ords.AccountId);
		}
	}

	List<AggregateResult> AggregateResultList = [
		SELECT AccountId, SUM(TotalAmount) amt
		FROM Order
		WHERE AccountId IN :accset
		GROUP BY AccountId
	];
	if (AggregateResultList != null && AggregateResultList.size() > 0) {
		for (AggregateResult aggr : AggregateResultList) {
			Account acc = new Account();
			acc.Id = (id) aggr.get('AccountId');
			acc.Chiffre_d_affaire__c = (decimal) aggr.get('amt');
			updateMap.put(acc.Id, acc);
		}
	} else {
		for (id idSet : accset) {
			Account acc = new Account();
			acc.Id = idSet;
			acc.Chiffre_d_affaire__c = 0;
			updateMap.put(acc.Id, acc);
		}
	}
	update updateMap.values();
}
