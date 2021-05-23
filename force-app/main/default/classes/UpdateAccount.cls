global class UpdateAccount implements Database.Batchable<sObject> {
	public integer countRecords = 0;
	global Database.QueryLocator start(Database.BatchableContext info) {
		//Query only accounts with at least one order with status 'Ordered'
		String query = 'SELECT Id FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE STATUS = \'Ordered\')';
		return Database.getQueryLocator(query);
	}

	global void execute(Database.BatchableContext info, Account[] scope) {
		countRecords += scope.size();
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
