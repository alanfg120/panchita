import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { AddproducComponent } from './addproduc.component';

describe('AddproducComponent', () => {
  let component: AddproducComponent;
  let fixture: ComponentFixture<AddproducComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ AddproducComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AddproducComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
