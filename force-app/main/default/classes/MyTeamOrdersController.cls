public with sharing class MyTeamOrdersController {
	public decimal SumOrders {
		// Return TotalAmount to visualforce page
		get {
			AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order];
			return (decimal) groupedResults.get('total');
		}
		set;
	}
}
