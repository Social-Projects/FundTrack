﻿import { Injectable } from "@angular/core";
import * as message from '../shared/common-message.storage';
import * as defaultConfig from '../shared/default-configuration.storage';
import { Image } from "../view-models/concrete/image.model";
import { BehaviorSubject } from "rxjs/BehaviorSubject";

@Injectable()
export class ImputImagService {
    private startFile: any;
    private currentImageFile: File;
    private image: Image;

    public MakeImage(file: any) {
        this.startFile = file;
        this.handleImageLoader();
        
    }

    private handleImageLoader() {
        this.currentImageFile = this.startFile.dataTransfer ? this.startFile.dataTransfer.files[0] : this.startFile.target.files[0];
        var reader = new FileReader();

        if (!this.currentImageFile.type.match(defaultConfig.imageRegExPattern)) {
            throw message.invalidFormat;
        }

        if (this.currentImageFile.size > defaultConfig.maxImageSize) {
            throw message.exceededImageSize + " " + message.acceptable + " " + defaultConfig.maxImageSize / 1000000 + "Мб";
        }

        reader.onloadend = this._handleReaderLoaded.bind(this);
        reader.readAsDataURL(this.currentImageFile);
    }

    private _handleReaderLoaded(e: any) {
        var reader = e.target;
        let newLogoUrl = reader.result;

        var commaInd = newLogoUrl.indexOf(',');
        let base64Code = newLogoUrl.substring(commaInd + 1);

        this.image = new Image(this.currentImageFile.name, newLogoUrl, base64Code);
    }

    public getWorkbookFromFile2(startFile: any): Promise<Image> {
        
        return new Promise<Image>((resolve, reject) => {

            let currentImageFile = startFile.dataTransfer ? startFile.dataTransfer.files[0] : startFile.target.files[0];

            if (!currentImageFile.type.match(defaultConfig.imageRegExPattern)) {
                reject(new Error( message.invalidFormat));
            }

            if (currentImageFile.size > defaultConfig.maxImageSize) {
                reject(new Error( message.exceededImageSize + " " + message.acceptable + " " + defaultConfig.maxImageSize / 1000000 + "Мб"));
            }

            var reader = new FileReader();

            reader.onload = (e: any) => {
                let newLogoUrl = e.target.result;

                var commaInd = newLogoUrl.indexOf(',');
                let base64Code = newLogoUrl.substring(commaInd + 1);

                let image = new Image(currentImageFile.name, newLogoUrl, base64Code);
                resolve(image);
            }
            reader.readAsDataURL(currentImageFile);
        });
    }
}