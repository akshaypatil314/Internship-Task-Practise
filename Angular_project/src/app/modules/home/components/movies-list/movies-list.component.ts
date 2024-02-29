import { Component, OnInit } from '@angular/core';
import { MoviesState } from '../../store/models/movie-state.model';
import { loadMovies } from '../../store/actions/data.action';
import { Store } from '@ngrx/store';
import { Movie } from '../../store/models/movie.model';


@Component({
  selector: 'app-movies-list',
  templateUrl: './movies-list.component.html',
  styleUrl: './movies-list.component.css'
})
export class MoviesListComponent implements OnInit {
  movies$: Movie[] = [];

  constructor(private store: Store<{ movie: MoviesState }>) { }

  ngOnInit() {
    this.store.dispatch(loadMovies());
    this.store.select('movie').subscribe(dataState => {
      this.movies$ = dataState.movies;
    });
  }
}
