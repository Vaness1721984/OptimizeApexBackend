global class UpdateAccount implements Database.Batchable<sObject> {
	public integer countRecords = 0;
	global Database.QueryLocator start(Database.BatchableContext info) {
		//Query only accounts with at least one order with status 'Ordered'
		/*	String query = 'SELECT Id FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE STATUS = \'Ordered\')';*/
		String query = 'SELECT Id FROM Account';
		return Database.getQueryLocator(query);
	}

	global void execute(Database.BatchableContext info, List<Order> scope) {
		countRecords += scope.size();

		map<id, Account> updateMap = new Map<id, Account>();
		set<ID> accset = new Set<ID>();

		for (Order ord : scope) {
			if (ord.AccountId != null)
				accset.add(ord.AccountId);
		}

		List<AggregateResult> AggregateResultList = [
			SELECT AccountId, SUM(TotalAmount) amt
			FROM Order
			WHERE Status = 'Ordered' AND AccountId IN :accset
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

	global void finish(Database.BatchableContext info) {
		System.debug(countRecords + ' records processed.');
		AsyncApexJob job = [
			SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email
			FROM AsyncApexJob
			WHERE Id = :info.getJobId()
		];
	}
}
