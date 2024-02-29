import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeContainerComponent } from './components/home-container/home-container.component';
import { PagenotfoundComponent } from '../../components/pagenotfound/pagenotfound.component';
import { MoviesListComponent } from './components/movies-list/movies-list.component';
import { SpecificMovieComponent } from './components/specific-movie/specific-movie.component';

const routes: Routes = [

  {
    path: "", component: HomeContainerComponent, children: [
      { path: "", component: MoviesListComponent },
      { path: ":id", component: SpecificMovieComponent },
      { path: '**', component: PagenotfoundComponent }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class HomeRoutingModule { }
