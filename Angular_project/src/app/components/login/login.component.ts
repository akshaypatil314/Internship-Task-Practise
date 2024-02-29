import { Component, OnInit } from '@angular/core';
import { AuthServiceService } from '../../services/AuthService/auth-service.service';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrl: './login.component.css'
})
export class LoginComponent implements OnInit {

  dynamicStyles: any;
  isAuthenticated = false;
  formData = {
    email: '',
    password: ''
  }

  constructor(private authService: AuthServiceService, private router: Router) {
    this.authService.clearCurrentUser();
  }

  ngOnInit() {
    this.dynamicStyles = { display: 'none' }
  }

  loginForm(form: NgForm) {
    this.isAuthenticated = this.authService.login(this.formData);
    if (this.isAuthenticated === false) {
      this.dynamicStyles = { display: 'block' }
    }
    this.router.navigate(['/home'])
    form.reset();
  }

  closePopup() {
    this.dynamicStyles = { display: 'none' }
    this.router.navigate(['/login']);
  }

}
