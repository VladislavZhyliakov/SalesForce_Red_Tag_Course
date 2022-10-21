
import { LightningElement,api, wire , track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import Delete_All_Leads_Message_1 from '@salesforce/label/c.Delete_All_Leads_Message_1'
import Delete_All_Leads_Message_2 from '@salesforce/label/c.Delete_All_Leads_Message_2'



import deleteAllLeads from '@salesforce/apex/deleteAllLeadsController.deleteAllLeads';


export default class LwcDeleteAllLeadsConfirmation extends LightningElement {
    @api name;
    @track isModalOpen = true;

    label={
        Delete_All_Leads_Message_1,
        Delete_All_Leads_Message_2
    }

   // ProceedBtnClick()
   // {
       // this.isModalOpen = true;

   // }

    deleteAll()
    {    
        const event = new ShowToastEvent({
            title: 'Deletetion in progress',
            message: this.label.Delete_All_Leads_Message_2,
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);

        deleteAllLeads({i:1});

        setTimeout(function(){
            window.location.reload();
        }, 2000); 

    }
    
    cancel()
    {
        this.isModalOpen = false;
    }

}



/*import { LightningElement,track } from 'lwc';
export default class ModalPopupLWC extends LightningElement {
    //Boolean tracked variable to indicate if modal is open or not default value is false as modal is closed when page is loaded 
    @track isModalOpen = false;
    openModal() {
        // to open modal set isModalOpen tarck value as true
        this.isModalOpen = true;
    }
    closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.isModalOpen = false;
    }
    submitDetails() {
        // to close modal set isModalOpen tarck value as false
        //Add your code to call apex method or do some processing
        this.isModalOpen = false;
    }
}*/