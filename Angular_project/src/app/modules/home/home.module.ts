import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HomeRoutingModule } from './home-routing.module';
import { NavbarComponent } from './components/navbar/navbar.component';
import { HomeContainerComponent } from './components/home-container/home-container.component';
import { MoviesListComponent } from './components/movies-list/movies-list.component';
import { SpecificMovieComponent } from './components/specific-movie/specific-movie.component';
import { HttpClientModule } from '@angular/common/http';
import { StoreModule } from '@ngrx/store';
import { moviesReducer } from './store/reducers/data.reducer';
import { EffectsModule } from '@ngrx/effects';
import { MoviesEffects } from './store/data.effects';


@NgModule({
  declarations: [
    NavbarComponent,
    HomeContainerComponent,
    MoviesListComponent,
    SpecificMovieComponent
  ],
  imports: [
    CommonModule,
    HomeRoutingModule,
    HttpClientModule,
    StoreModule.forFeature('movie', moviesReducer),
    EffectsModule.forFeature([MoviesEffects])
  ]
})
export class HomeModule {

}
