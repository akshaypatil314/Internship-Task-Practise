import { Injectable } from '@angular/core';
import { PasswordServiceService } from '../PasswordService/password-service.service';



@Injectable({
  providedIn: 'root'
})
export class AuthServiceService {

  users: any[] = [];
  constructor(private passwordService: PasswordServiceService) { }

  register(userData: any): any {
    if (this.users.length === 0) {
      this.users.push(userData)
      localStorage.setItem("users", JSON.stringify(this.users));
      return true;
    }
    else {
      for (let i = 0; i < this.users.length; i++) {
        if (!(userData.email == this.users[i].email)) {
          this.users.push(userData)
          localStorage.setItem("users", JSON.stringify(this.users));
          return true;
        }
        else {
          return false;
        }
      }
    }
  }

  login(userData: any): boolean {
    const storedUsers = JSON.parse(localStorage.getItem("users") || "[]")

    const user = storedUsers.find((val: any) => {
      return val.email === userData.email && this.passwordService.verifyPassword(userData.password, val.password);
    })

    if (user) {
      localStorage.setItem("currentUser", JSON.stringify(user));
      return true;
    }
    else {
      return false;
    }
  }

  isLoggedIn() {
    return !!localStorage.getItem('currentUser');
  }

  getUserName(): any {
    if (this.isLoggedIn()) {
      const userName = JSON.parse(localStorage.getItem("currentUser") || "[]");
      return userName;
    }
  }

  logout() {
    localStorage.removeItem("currentUser");
  }

  clearCurrentUser(): void {
    localStorage.removeItem('currentUser');
  }

}
