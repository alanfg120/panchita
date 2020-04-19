import { Component, OnInit } from '@angular/core';
import {MatDialog} from '@angular/material/dialog';
import { AddproducComponent } from '../addproduc/addproduc.component';
@Component({
  selector: 'app-productos',
  templateUrl: './productos.component.html',
  styleUrls: ['./productos.component.css']
})
export class ProductosComponent implements OnInit {

  productos = new Array(0);
  
  constructor(
    public dialog:MatDialog
  ) {}

  ngOnInit() {
   
  }

  AddProductodialog(){
    this.dialog.open(AddproducComponent,{
      width:'600px'
    })
  }
}
