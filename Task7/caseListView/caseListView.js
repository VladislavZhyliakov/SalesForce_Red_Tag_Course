import AboutMe from '@salesforce/schema/User.AboutMe';
import { LightningElement, wire, api , track} from 'lwc';
import getCasesBranch from "@salesforce/apex/caseListViewHelper.getCasesBranch"
import {refreshApex} from '@salesforce/apex'
import SuppliedPhone from '@salesforce/schema/Case.SuppliedPhone';
import UserPermissionsCallCenterAutoLogin from '@salesforce/schema/User.UserPermissionsCallCenterAutoLogin';
import { subscribe, unsubscribe, onError, setDebugFlag, isEmpEnabled }  from 'lightning/empApi';
import caseCreationNotifiSound from '@salesforce/resourceUrl/caseCreationNotifiSound'


const ACTIONS = [{label:'Details', name: 'details'}]

const COLS  = [{label: 'Case Number', fieldName: 'link', type: 'url', typeAttributes:{label:{fieldName:'CaseNumber'}}},
               {label: 'Created Date', fieldName: 'CreatedDate'},
               {label: 'Status', fieldName:'Status'},
               {fieldName: "actions", type:"action", typeAttributes:{rowActions:ACTIONS}}
              ]

export default class CaseListView extends LightningElement {
    cols = COLS;
    showDetails = false;

    subscription = {};
    channelName = '/event/Case_Created__e';

    usersBranchNumber;

    @track cases=[];
    wiredCases;

    caseID;

    connectedCallback()
    {
       this.getCasesFromBranch();
       this.handleSubscribe();
    }

    getCasesFromBranch()
    {
         getCasesBranch()
         .then(result =>{
             this.wiredCases=result;
             this.usersBranchNumber = this.wiredCases.Branch_Number__c;
             console.log('\n\n\n\n'+ this.usersBranchNumber+ '\n\n\n\n');
 
 
             this.cases = this.wiredCases.map((row)=>
             {
                 return this.mapCases(row);
             });
         })
         .catch(error=>{
             console.log(error);
         });
    }

    mapCases(row)
    {
        console.log(row);
        return{...row,
            CaseNumber: `${row.CaseNumber}`,
            link: `/${row.Id}`,
            CreatedDate: `${row.CreatedDate}`,
            Status:`${row.Status}`
        };
    }

    handleSubscribe()
    {
        const messageCallback = (response) =>{
                let notifSound = new Audio();
                notifSound.src =caseCreationNotifiSound ;
                notifSound.load();
                notifSound.play();
                this.getCasesFromBranch();
        };

        subscribe(this.channelName, -1, messageCallback)
        .then(response => {
            this.subscription = response;
        })
        .catch(error => {
            console.error('handleSubscribe: ',error);
        });
    }

    handleRowAction(event)
    {
        this.showDetails = true;

        this.caseID = event.detail.row.Id;

        this.getCasesFromBranch();
    }

    handleRowSelection()
    {
        alert("Stay Tuned");
    }  
}