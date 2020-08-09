import { Component, OnInit, OnDestroy } from '@angular/core';
import { Subscription } from 'rxjs';
import { Store } from '@ngrx/store';

import { LoginState } from '../../../login/reducers/login_reducer';
import { logout } from 'src/app/login/actions/login_action';


@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css'],
})
export class HomeComponent implements OnInit {
  private subscription: Subscription;
  public message: any;
  snackbar;
  constructor(
    private storelogin: Store<{ login: LoginState }>,

  ) {}

  ngOnInit(): void {

  }

  outlogin(): void{
    this.storelogin.dispatch(logout());
  }
}
