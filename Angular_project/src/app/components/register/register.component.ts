import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthServiceService } from '../../services/AuthService/auth-service.service';
import { PasswordServiceService } from '../../services/PasswordService/password-service.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrl: './register.component.css'
})
export class RegisterComponent implements OnInit {

  isRegistered: boolean = false;
  dynamicStyles: any;
  formData = {
    name: '',
    email: '',
    password: '',
    mobile: ''
  }

  constructor(private authService: AuthServiceService, private passwordService: PasswordServiceService, private router: Router) {
    this.authService.clearCurrentUser();
  }

  ngOnInit() {
    this.dynamicStyles = {
      display: 'none'
    }
  }

  SubmitForm(form: NgForm) {
    let hashedPassword = this.passwordService.hashPassword(this.formData.password);
    this.formData.password = hashedPassword;
    this.isRegistered = this.authService.register(this.formData);
    this.isRegistered ? this.dynamicStyles = { display: 'block' } : this.dynamicStyles = { display: 'block' }
    form.reset();
  }

  closePopup() {
    this.dynamicStyles = {
      display: 'none'
    }
    this.isRegistered ? this.router.navigate(['/login']) : this.router.navigate(['/']);
  }
}
