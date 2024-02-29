import { Component } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { AuthServiceService } from '../../../../services/AuthService/auth-service.service';

@Component({
  selector: 'app-home-container',
  templateUrl: './home-container.component.html',
  styleUrl: './home-container.component.css'
})
export class HomeContainerComponent {

  constructor(private activatedRoute: ActivatedRoute, private authService: AuthServiceService) {

  }


}
