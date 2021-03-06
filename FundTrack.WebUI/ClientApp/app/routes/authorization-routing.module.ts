﻿import { NgModule } from "@angular/core";
import { RouterModule } from "@angular/router";
import { RegistrationComponent } from "../components/registration/registration.component";
import { AuthorizationComponent } from "../components/authorization/authorization.component";
import { UserProfileComponent } from '../components/user-profile/user-profile.component';
import { PartnerRouteGuard } from '../services/concrete/security/partner-route-guard';
import { ErrorAuthorizeComponent } from '../shared/components/error-authorize/error-authorize.component';
import { BeginPasswordResetComponent } from '../components/password-reset/begin-password-reset.component';
import { NewPasswordComponent } from '../components/password-reset/new-password.component';

@NgModule({
    providers: [PartnerRouteGuard],
    imports: [
        RouterModule.forChild([
            { path: 'login', component: AuthorizationComponent },
            { path: 'registration', component: RegistrationComponent },
            {
                path: 'userprofile',
                component: UserProfileComponent,
                canActivate: [PartnerRouteGuard]
            },
            { path: 'errorauthorize', component: ErrorAuthorizeComponent },
            { path: 'begin_password_reset', component: BeginPasswordResetComponent },
            { path: 'new_password/:id', component: NewPasswordComponent }
        ])
    ],
    exports: [RouterModule]
})
export class AuthorizationRoutingModule { }