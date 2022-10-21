import { LightningElement, track, wire, api } from 'lwc';
import caseDetails from "@salesforce/apex/caseDetailsHelper.caseDetails"
import setStatus from "@salesforce/apex/setCaseStatusController.setStatus"



export default class CaseDetailsSplit extends LightningElement {
   
   @track caseDetailsTracker;
   @api getCase;
  

    @wire (caseDetails, {caseIdForDetails: '$getCase'})
    getCaseDetails({error, data})
    {
        if(data)
        {
           this.caseDetailsTracker = data;
           setStatus({caseIdForDetails:this.getCase});
        }
        else if(error)
        {
            alert(error);
        }
    }
}