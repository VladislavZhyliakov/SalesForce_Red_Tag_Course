import { LightningElement, wire , track } from 'lwc';

//import Product from '@salesforce/schema/Lead__Product__c';
import insertLead from '@salesforce/apex/task5_insert_lead.insertLead';
//import Account from '@salesforce/schema/Case.Account';

export default class Task5_contact_us extends LightningElement {
   


    productOptions = [
        {"label": "Sales Cloud", "value": "Sales Cloud"},
        {"label": "Service Cloud", "value": "Service Cloud"},
        {"label": "Community Cloud", "value": "Community Cloud"},
        {"label": "Marketing Cloud", "value": "Marketing Cloud"},
        {"label": "Integration Cloud", "value": "Integration Cloud"}

    ];

    isInputValid()
    {
        let isValid = true;
        let inputFields = this.template.querySelectorAll('lightning-input');
            
        inputFields.forEach(inputField => {
            if(!inputField.checkValidity()) {
                inputField.reportValidity();
                isValid = false;
            }
         
        });

        let inputFieldProduct = this.template.querySelector('.Product');
        
        if(!inputFieldProduct.checkValidity())
        {
            inputFieldProduct.reportValidity();
            isValid = false;
        }

        return isValid;
    }
    
    updateText() {

        if(this.isInputValid())
        {
            var strFName = this.template.querySelector('.FirstName').value;
            var strLName = this.template.querySelector('.LastName').value;
            var strEmail = this.template.querySelector('.Email').value;
            var strPhone = this.template.querySelector('.Phone').value;

            var strQuestion = this.template.querySelector('.Question').value;
            var strProduct = this.template.querySelector('.Product').value;

           insertLead({fname: strFName, lname: strLName, email: strEmail, phone:strPhone, question:strQuestion, product: strProduct})

            alert('We have got your appeal. Thank You!');

            this.template.querySelectorAll('lightning-input').forEach(element => {
                element.value = null;
            });

            this.template.querySelectorAll('lightning-combobox').forEach(element => {
                element.value = null;
            });

            this.template.querySelectorAll('lightning-textarea').forEach(element => {
                element.value = null;
            });
        }

    }

}