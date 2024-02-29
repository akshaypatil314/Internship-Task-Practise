import { Component, Input } from '@angular/core';
import { AuthServiceService } from '../../../../services/AuthService/auth-service.service';
import { Route, Router } from '@angular/router';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',
  styleUrl: './navbar.component.css'
})
export class NavbarComponent {

  name: string = '';
  constructor(private authService: AuthServiceService, private router: Router) {
    const data = this.authService.getUserName();
    this.name = data.name;
  }
  logoutUser() {
    this.authService.logout();
    this.router.navigate(['/login']);
  }
}
