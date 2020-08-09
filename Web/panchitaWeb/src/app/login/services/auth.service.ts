import { Injectable } from '@angular/core';

import {
  Router,
  ActivatedRouteSnapshot,
  RouterStateSnapshot,
  CanActivate
} from '@angular/router';



@Injectable({
  providedIn: 'root'
})
export class AuthService implements CanActivate {
  constructor(
    private router: Router,
  ) {}

  // tslint:disable-next-line: typedef
  canActivate(netx: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
    if (sessionStorage.getItem('id_session')) {
      return true;
    } else {
      this.router.navigate(['login']);
      return false;
    }
  }
}
