global class BatchUpdateAccount implements Database.Batchable<AggregateResult>, Database.Stateful {
	public Integer recordsProcessed = 0;
	global Iterable<AggregateResult> start(Database.BatchableContext info) {
		// Query only accounts with at least one order with status 'Ordered'
		String query = 'SELECT AccountId, SUM(TotalAmount) amt FROM Order WHERE Status = \'Ordered\' GROUP BY AccountId';
		// Instantiate the new iterable
		return new AggregateResultIterable(query);
	}

	global void execute(Database.BatchableContext info, List<sObject> scope) {
		// Execute batch of records
		map<id, Account> updateMap = new Map<id, Account>();
		// For loop to update Chiffre_d_affaire__c field with sum of TotalAmount field per order
		for (sObject sObj : scope) {
			AggregateResult ar = (AggregateResult) sObj;
			Account acc = new Account();
			acc.Id = (id) ar.get('AccountId');
			acc.Chiffre_d_affaire__c = (decimal) ar.get('amt');
			updateMap.put(acc.Id, acc);
			// Count of records processed
			recordsProcessed = recordsProcessed + 1;
		}
		// Update list of values with Map method (key: AccountId & value : Chiffre_d_affaire__c)
		update updateMap.values();
	}

	global void finish(Database.BatchableContext info) {
		// Display job information in debug console
		AsyncApexJob job = [
			SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email
			FROM AsyncApexJob
			WHERE Id = :info.getJobId()
		];
		System.debug(job);
		// Display total of processed records in debug console
		System.debug(recordsProcessed + ' records processed.');
	}
}
