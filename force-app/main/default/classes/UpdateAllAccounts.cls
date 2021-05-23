global class UpdateAllAccounts implements Database.Batchable<sObject> {
	global Database.QueryLocator start(Database.BatchableContext info) {
		//Query only accounts with at least one order withstatus 'Ordered'
		return Database.getQueryLocator(
			'SELECT Id FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE STATUS = \'Ordered\')'
		);
	}

	global void execute(Database.BatchableContext info, List<Account> scope) {
		Set<Id> setAccountIds = (new Map<Id, SObject>(scope)).keySet();
		/*AP01Account.updateChiffreAffaire(setAccountIds);*/
	}

	global void finish(Database.BatchableContext info) {
	}
}
