import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { FetchDataService } from '../../services/DataFetch/fetch-data.service';
import { Store } from '@ngrx/store';
import { MoviesState } from '../../store/models/movie-state.model';

@Component({
  selector: 'app-specific-movie',
  templateUrl: './specific-movie.component.html',
  styleUrl: './specific-movie.component.css'
})
export class SpecificMovieComponent implements OnInit {

  movieId: any;
  movieDetails: { id: string, title: string, releaseYear: string } | undefined;

  constructor(private route: ActivatedRoute, private fetchData: FetchDataService, private store: Store<{ movie: MoviesState }>) { }

  ngOnInit() {
    this.route.params.subscribe((params) => {
      this.movieId = params['id'];
    });

    this.store.select('movie').subscribe(dataState => {
      this.movieDetails = dataState.movies.find((movie: any) => movie.id === this.movieId);
    });
  }

}
