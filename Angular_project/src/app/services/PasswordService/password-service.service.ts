import { Injectable } from '@angular/core';
import CryptoJS from 'crypto-js';

@Injectable({
  providedIn: 'root'
})
export class PasswordServiceService {

  constructor() { }

  hashPassword(password: string): string {
    return CryptoJS.SHA256(password).toString();
  }

  verifyPassword(inputPassword: string, hasedPassword: string): boolean {
    const inputHash = this.hashPassword(inputPassword);
    return inputHash === hasedPassword;
  }
}

