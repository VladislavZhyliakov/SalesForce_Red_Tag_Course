({
	doInit : function(component, event, helper) {
		component.set('v.columns', [
            {label: 'Opportunity name', fieldName: 'OpportunityUrl', type: 'url', typeAttributes:{label:{fieldName:'Name'}}},
            {label: 'Amount', fieldName: 'Amount', type: 'currency'},
			{label: 'Close Date', fieldName: 'CloseDate', type: 'date'},
			{label: 'Stage', fieldName: 'StageName', type: 'text'},
        ]);
		var action = component.get('c.GetTop5OppsByAmount');
		action.setCallback(this,function(Response){
			var state = Response.getState();
		
			if(state === 'SUCCESS'|| state === 'DRAFT'){
				var responseValue = Response.getReturnValue();
				responseValue.forEach(function(record){
					record['OpportunityUrl'] = '/lightning/r/Opportunity/'+record['Id']+'/view';
				});
				console.log('responseValue ', responseValue);
				component.set('v.data', responseValue);
			}
		});
		$A.enqueueAction(action);
	}
})