import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { AddvendedorComponent } from './addvendedor.component';

describe('AddvendedorComponent', () => {
  let component: AddvendedorComponent;
  let fixture: ComponentFixture<AddvendedorComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ AddvendedorComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AddvendedorComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
