// movies.reducer.ts
import { createReducer, on } from '@ngrx/store';
import { loadMovies, loadMoviesSuccess, loadMoviesFailure } from '../actions/data.action';
import { MoviesState } from '../models/movie-state.model';

export const initialState: MoviesState = {
    movies: [],
};

export const moviesReducer = createReducer(
    initialState,
    on(loadMovies, (state) => ({ ...state })),
    on(loadMoviesSuccess, (state, { movies }) => ({ ...state, movies })),
    on(loadMoviesFailure, (state, { error }) => ({ ...state, error })),
);
