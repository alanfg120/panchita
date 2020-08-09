import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { StoreModule } from '@ngrx/store';
import { EffectsModule } from '@ngrx/effects';
import { StoreRouterConnectingModule, routerReducer } from '@ngrx/router-store';
import { StoreDevtoolsModule } from '@ngrx/store-devtools';
import { environment } from '../environments/environment';
import { AngularFireModule} from '@angular/fire';
import { AngularFirestore, AngularFirestoreModule } from '@angular/fire/firestore';
import { AngularFireStorage, AngularFireStorageModule } from '@angular/fire/storage';
import { AngularFireMessagingModule } from '@angular/fire/messaging';
import { AngularFireAuthModule, } from '@angular/fire/auth';
import {MatSnackBarModule} from '@angular/material/snack-bar';
import { LoginReducer } from './login/reducers/login_reducer';
import { PedidosReducer } from './pedidos/reducers/pedido_reducer';
import { PedidosEffects } from './pedidos/affects/pedidos_effect';
import { VendedoresReducer } from './vendedores/reducers/vendedor_reducer';
import { ProductosEffects } from './productos/effects/productos_effect';
import { VendedoresEffect } from './vendedores/effects/vendedores_effects';
import { LoginEffects } from './login/effects/login_effects';
import { HttpClientModule } from '@angular/common/http';
import { ProductoReducer } from './productos/reducer/productos_reducer';
@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    BrowserAnimationsModule,
    StoreModule.forRoot({
      login: LoginReducer,
      router: routerReducer,
      productos: ProductoReducer,
      pedidos : PedidosReducer,
      vendedores: VendedoresReducer
    }),
    EffectsModule.forRoot([LoginEffects, ProductosEffects, PedidosEffects, VendedoresEffect]),
    StoreRouterConnectingModule.forRoot(),
    StoreDevtoolsModule.instrument({ maxAge: 25, logOnly: environment.production }),
    AngularFireModule.initializeApp(environment.firebaseConfig),
    AngularFireStorageModule,
    AngularFirestoreModule,
    AngularFireMessagingModule,
    AngularFireAuthModule,
    MatSnackBarModule,
  ],
  providers: [AngularFirestore, AngularFireStorage],
  bootstrap: [AppComponent]
})
export class AppModule { }
