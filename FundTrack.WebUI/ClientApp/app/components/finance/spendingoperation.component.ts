﻿import { ViewChild, Component, OnInit, Input, SimpleChange, OnChanges, Output, EventEmitter } from "@angular/core";
import { Router } from "@angular/router";
import { OrgAccountService } from "../../services/concrete/finance/orgaccount.service";
import { OrgAccountViewModel } from "../../view-models/concrete/finance/orgaccount-viewmodel";
import { FixingBalanceService } from "../../services/concrete/fixing-balance.service";
import * as key from '../../shared/key.storage';
import * as constant from '../../shared/default-configuration.storage';
import * as message from '../../shared/common-message.storage';
import { FinOpService } from "../../services/concrete/finance/finOp.service";
import { FinOpListViewModel } from "../../view-models/concrete/finance/finop-list-viewmodel";
import { isBrowser } from "angular2-universal";
import { ModalComponent } from "../../shared/components/modal/modal-component";
import { FormGroup, FormBuilder, Validators } from "@angular/forms";
import { ValidatorsService } from "../../services/concrete/validators/validator.service";
import Core = require("@angular/core");
import Targetviewmodel = require("../../view-models/concrete/finance/donate/target.view-model");
import { Image } from "../../view-models/concrete/image.model";
import { EditOrganizationService } from "../../services/concrete/organization-management/edit-organization.service";
import { ModeratorViewModel } from '../../view-models/concrete/edit-organization/moderator-view.model';
import { AuthorizeUserModel } from "../../view-models/concrete/authorized-user-info-view.model";
import { TargetViewModel } from "../../view-models/concrete/finance/donate/target.view-model";
import { UserInfo } from "../../view-models/concrete/user-info.model";
import { Location } from '@angular/common';
import { ActivatedRoute } from "@angular/router";
import { UserService } from "../../services/concrete/user.service";

@Component({
    selector: 'spendingoperation',
    templateUrl: './spendingoperation.component.html',
    styleUrls: ['./spendingoperation.component.css'],
    providers: [OrgAccountService, EditOrganizationService, UserService, FixingBalanceService]
})

export class SpendingOperationComponent {

    @ViewChild("targetModal")
    public targetModal: ModalComponent;

    private moneySpendingForm: FormGroup;
    private moneyOperationModel: FinOpListViewModel = new FinOpListViewModel();
    private moneySpending: FinOpListViewModel = new FinOpListViewModel();
    private cashAccounts: OrgAccountViewModel[] = new Array<OrgAccountViewModel>();
    private currentAccount: OrgAccountViewModel = new OrgAccountViewModel();
    private orgTargets: TargetViewModel[] = new Array<TargetViewModel>();
    private baseTargets: TargetViewModel[] = new Array<TargetViewModel>();
    private subTargets: TargetViewModel[] = new Array<TargetViewModel>();
    private newSubTarget: TargetViewModel = new TargetViewModel();
    private currentDate = new Date().toJSON().slice(0, 10);
    private currentAccountId: number;
    private currentTarget: TargetViewModel = new TargetViewModel();
    private user: AuthorizeUserModel = new AuthorizeUserModel();
    private nullTarget: TargetViewModel = { isDeletable: false, name: constant.nullTargetUA, organizationId: this.user.orgId, parentTargetId: null, targetId: null };
    private minDate: string;
    private isAccountChosen: boolean = false;
    private isAccountKnown: boolean = false;
    private isTargetNull: boolean = true;
    private isNewSubTargetCreated = false;
    private images: Image[] = [];

    public constructor(private router: Router,
        private location: Location,
        private route: ActivatedRoute,
        private finOpService: FinOpService,
        private fb: FormBuilder,
        private validatorsService: ValidatorsService,
        private accountService: OrgAccountService,
        private userService: UserService,
        private editService: EditOrganizationService,
        private fixingService: FixingBalanceService) {
        this.createSpendingForm();
    }

    ngOnInit(): void {
        this.initialize();
    }

    private initializeCurrentOrgAccount(accountId: number) {
        this.moneyOperationModel = new FinOpListViewModel();
        this.moneyOperationModel.date = new Date();
        this.accountService.getOrganizationAccountById(accountId)
            .subscribe(currAcc => {
                this.currentAccount = currAcc;
                this.getCurrentTarget();
                this.getMinDate();
            });
    }

    private initialize() {
        this.getLoggedUser();
        this.initializeTargets();
        this.route.params.subscribe(params => {
            this.currentAccountId = params['id'];
            if (this.currentAccountId == undefined) {
                this.getOrganizationCashAccounts();
            }
            else {
                this.isAccountKnown = true;
                this.isAccountChosen = true;
                this.initializeCurrentOrgAccount(this.currentAccountId);
            }
        });
    }

    private onAccountSelect(accountId: number) {
        this.initializeCurrentOrgAccount(accountId);
        this.isAccountChosen = true;
    }

    private initializeTargets() {
        this.editService.getTargetsByOrganizationId(this.user.orgId)
            .subscribe(t => {
                this.orgTargets = t;
                this.getBaseTargets();
            });
    }

    private getBaseTargets() {
        for (let i = 0; i < this.orgTargets.length; i++) {
            if (this.orgTargets[i].parentTargetId == null) {
                this.baseTargets.push(this.orgTargets[i]);
            }
        }
    }

    private getSubTargetsByTargetId(parentTargetId: number) {
        this.subTargets = new Array<TargetViewModel>();
        for (let i = 0; i < this.orgTargets.length; i++) {
            if (this.orgTargets[i].parentTargetId == parentTargetId) {
                this.subTargets.push(this.orgTargets[i]);
            }
        }

        if (this.subTargets.length == 0) {
            this.moneyOperationModel.targetId = parentTargetId;
        }

    }

    private addSubTarget(targetName: string) {
        this.newSubTarget = {
            targetId: 0,
            name: targetName,
            organizationId: this.user.orgId,
            parentTargetId: this.currentTarget.targetId,
            isDeletable: false
        }
        this.subTargets.push(this.newSubTarget);
        this.isNewSubTargetCreated = true;
        this.moneyOperationModel.targetId = this.newSubTarget.targetId;
        this.closeModal();
    }

    private getCurrentTarget() {
        if (this.currentAccount.targetId != null) {
            this.currentTarget = this.baseTargets.find(target => target.targetId == this.currentAccount.targetId);
            this.getSubTargetsByTargetId(this.currentTarget.targetId);
            this.isTargetNull = false;
        }
        else {
            this.currentTarget = this.nullTarget;
            this.getSubTargetsByTargetId(this.currentTarget.targetId);
            this.isTargetNull = true;
            this.moneyOperationModel.targetId = this.nullTarget.targetId;
        }
    }

    public getMinDate() {
        this.fixingService.getFilterByAccId(this.currentAccount.id)
            .subscribe(fix => {
                if (fix.lastFixing.balanceDate == null) {
                    this.minDate = this.currentAccount.creationDate.toJSON().slice(0, 10);
                }
                else {
                    this.minDate = fix.lastFixing.balanceDate.slice(0, 10);
                }
            });
    }

    private getOrganizationCashAccounts() {
        this.accountService.getAllAccountsOfOrganization()
            .subscribe(acc => {
                this.cashAccounts = acc.filter(a =>
                    a.accountType == constant.cashUA
                );
            });
    }

    public getLoggedUser() {
        this.user = JSON.parse(localStorage.getItem(key.keyModel)) as AuthorizeUserModel;
    }

    public setDate(model: FinOpListViewModel, date: Date) {
        model.date = date;
    }

    private onImageChange(imgArr: Image[]) {
        this.images = imgArr;
    }

    private createSpendingForm() {
        this.moneySpendingForm = this.fb.group({
            cardFromId: [
                this.moneyOperationModel.accFromId
            ],
            amount: [
                this.moneyOperationModel.amount, [Validators.required,
                this.validatorsService.isMinValue,
                this.validatorsService.isMaxValue,
                this.validatorsService.isNumber
                ]
            ],
            targetId: [
                this.moneyOperationModel.targetId
            ],
            description: [
                this.moneyOperationModel.description, [Validators.maxLength(500)]
            ],
            date: [
                this.moneyOperationModel.date
            ]
        });
        this.moneySpendingForm.valueChanges
            .subscribe(a => this.onValueChange(a));
        this.onValueChange();
    }

    private formSpendingErrors = {
        amount: "",
        description: ""
    };

    private invalidAmountMessage = message.invalidAmountMessage;
    private maxLengthDescription = message.maxLengthDescription;

    private validationMessages = {
        amount: {
            notnumber: this.invalidAmountMessage,
            notminvalue: this.invalidAmountMessage,
            notmaxvalue: this.invalidAmountMessage
        },
        description: {
            maxlength: this.maxLengthDescription
        }
    }

    private onValueChange(data?: any) {
        if (!this.moneySpendingForm) return;
        let form = this.moneySpendingForm;

        for (let field in this.formSpendingErrors) {
            this.formSpendingErrors[field] = "";
            let control = form.get(field);

            if (control && control.dirty && !control.valid) {
                let message = this.validationMessages[field];
                for (let key in control.errors) {
                    this.formSpendingErrors[field] = message[key.toLowerCase()];
                }
            }
        }
    }

    private openModal() {
        this.targetModal.show();
    }

    private closeModal() {
        this.targetModal.hide();
    }

    private prepareSpending() {
        if (this.isNewSubTargetCreated) {
            this.editService.addTarget(this.newSubTarget).subscribe(result => {
                this.newSubTarget = result;
                this.moneyOperationModel.targetId = this.newSubTarget.targetId;
                this.makeSpending();
            });
        }
        else {
            this.makeSpending();
        }  
    }

    private makeSpending(): void {
        this.completeModel();
        this.finOpService.createSpending(this.moneyOperationModel).subscribe(a => {
            if (a.error == "" || a.error == null) {
                this.showToast();
                setTimeout(() => {
                    this.router.navigate(['finance/orgaccounts']);
                },
                    2000);

            } else {
                this.moneyOperationModel.error = a.error;
            }
        });
    }

    private completeModel() {
        this.moneyOperationModel.accFromId = this.currentAccount.id;
        this.moneyOperationModel.finOpType = constant.spendingId;
        this.moneyOperationModel.orgId = this.user.orgId;
        this.moneyOperationModel.userId = this.user.id;
        this.moneyOperationModel.images = this.images;
    }

    public showToast() {
        var x = document.getElementById("snackbar");
        x.className = "show";
        setTimeout(function () { x.className = x.className.replace("show", ""); }, 3000);
    }


    private navigateBack(): void {
        this.location.back();
    }
}