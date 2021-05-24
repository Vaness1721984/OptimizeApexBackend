public with sharing class MyTeamOrdersController {
	public decimal SumOrders {
		get {
			AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order];
			return (decimal) groupedResults.get('total');
		}
		set;
	}
}
