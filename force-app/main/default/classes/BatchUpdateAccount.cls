global class BatchUpdateAccount implements Database.Batchable<AggregateResult>, Database.Stateful {
	public Integer recordsProcessed = 0;
	global Iterable<AggregateResult> start(Database.BatchableContext info) {
		//Query only accounts with at least one order with status 'Ordered'
		String query = 'SELECT AccountId, SUM(TotalAmount) amt FROM Order WHERE Status = \'Ordered\' GROUP BY AccountId';
		return new AggregateResultIterable(query);
	}

	global void execute(Database.BatchableContext info, List<sObject> scope) {
		map<id, Account> updateMap = new Map<id, Account>();

		for (sObject sObj : scope) {
			AggregateResult ar = (AggregateResult) sObj;
			Account acc = new Account();
			acc.Id = (id) ar.get('AccountId');
			acc.Chiffre_d_affaire__c = (decimal) ar.get('amt');
			updateMap.put(acc.Id, acc);
			recordsProcessed = recordsProcessed + 1;
		}
		update updateMap.values();
	}

	global void finish(Database.BatchableContext info) {
		AsyncApexJob job = [
			SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email
			FROM AsyncApexJob
			WHERE Id = :info.getJobId()
		];
		System.debug(job);
		System.debug(recordsProcessed + ' records processed.');
	}
}
