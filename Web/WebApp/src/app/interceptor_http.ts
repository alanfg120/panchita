import { Injectable, NgModule } from "@angular/core";
import {
  HttpEvent,
  HttpInterceptor,
  HttpHandler,
  HttpRequest
} from "@angular/common/http";
import { HTTP_INTERCEPTORS } from "@angular/common/http";
import { Observable } from "rxjs";

@Injectable()
export class HttpsRequestInterceptor implements HttpInterceptor {
  intercept(
    req: HttpRequest<any>,
    next: HttpHandler
  ): Observable<HttpEvent<any>> {
    const dupReq = req.clone({
      headers: req.headers.set(
        "Authorization",
        `key=AAAAdH6_KEM:APA91bGhFWbLdqLpblST63fbDM-Fd5LK34Z8mXXxyt2YibueEOjBIOjktKnoy5OxvnKCxRMnl5JfI389mlRs77PuqztCGWxqtAHfcHcUjx2m5Gc8arxPKAx5Y0FiXJVgyn9ldwiQcHco`
      )
    });
    return next.handle(dupReq);
  }
}
@NgModule({
  providers: [
    {
      provide: HTTP_INTERCEPTORS,
      useClass: HttpsRequestInterceptor,
      multi: true
    }
  ]
})
export class Interceptor {}
