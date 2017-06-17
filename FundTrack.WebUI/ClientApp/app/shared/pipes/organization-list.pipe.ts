﻿import { Pipe, PipeTransform } from "@angular/core";
import { IOrganizationsForLayout } from "../../view-models/abstract/organizations-for-layout.interface";

@Pipe({
    name: 'organizationsListPipe'
})

/** filtering whole list of organizaions by keyword. */
export class DropdownOrganizationFilterPipe implements PipeTransform {
    /**
     * filters list of organizations by name
     * @param value : IOrganizationsForLayout[]
     * @param filterBy : string
     * @returns filtered IOrganizationsForLayout[] by string
     */
    transform(value: IOrganizationsForLayout[], filterBy: string): IOrganizationsForLayout[] {
        filterBy = filterBy ? filterBy.toLocaleLowerCase() : null;
        return filterBy ? value.filter((carModel: IOrganizationsForLayout) =>
            carModel.name.toLocaleLowerCase().indexOf(filterBy) !== -1) : value;
    }
}