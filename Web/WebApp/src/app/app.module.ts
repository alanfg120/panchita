import { BrowserModule } from "@angular/platform-browser";
import { NgModule } from "@angular/core";
import { AppRoutingModule } from "./app-routing.module";
import { AppComponent } from "./app.component";
import { BrowserAnimationsModule } from "@angular/platform-browser/animations";
import { StoreModule } from "@ngrx/store";
import { EffectsModule } from "@ngrx/effects";
import { StoreDevtoolsModule } from "@ngrx/store-devtools";
import { HttpClientModule } from "@angular/common/http";
import { LoginReducer } from "./login/reducers/login_reducer";
import { LoginEffects } from "./login/effects/login_effects";
import { Interceptor } from "./interceptor_http";
import { StoreRouterConnectingModule, routerReducer } from "@ngrx/router-store";
import { CustomSerializer } from "./router-store/custom-route-serializer";
import { MatSnackBarModule } from "@angular/material";
import { AngularFireModule} from '@angular/fire';
import { environment } from 'src/environments/environment';
import { AngularFirestore, AngularFirestoreModule } from '@angular/fire/firestore';
import { AngularFireStorage, AngularFireStorageModule } from '@angular/fire/storage';
import { ProductoReducer } from './productos/reducer/productos_reducer';
import { ProductosEffects } from './productos/effects/productos_effect';
import { PedidosReducer } from './pedidos/reducers/pedido_reducer';
import { PedidosEffects } from './pedidos/affects/pedidos_effect';

@NgModule({
  declarations: [AppComponent],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    BrowserAnimationsModule,
    StoreModule.forRoot({
      login: LoginReducer,
      router: routerReducer,
      productos: ProductoReducer,
      pedidos : PedidosReducer
    }),
    EffectsModule.forRoot([LoginEffects,ProductosEffects,PedidosEffects]),
    StoreDevtoolsModule.instrument({
      maxAge: 25,
    }),
    Interceptor,
    StoreRouterConnectingModule.forRoot({ serializer: CustomSerializer }),
    AngularFireModule.initializeApp(environment.firebaseConfig),
    AngularFireStorageModule,
    AngularFirestoreModule,
    MatSnackBarModule,
  ],
  providers: [AngularFirestore,AngularFireStorage],
  bootstrap: [AppComponent],
})
export class AppModule {}
