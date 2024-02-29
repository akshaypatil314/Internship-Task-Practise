// movies.effects.ts
import { Injectable } from '@angular/core';
import { mergeMap, map, catchError } from 'rxjs/operators';
import { of } from 'rxjs';
import { loadMovies, loadMoviesSuccess, loadMoviesFailure } from '../store/actions/data.action';
import { DataService } from '../services/data.service';
import { Actions, createEffect, ofType } from '@ngrx/effects';

@Injectable()
export class MoviesEffects {

    constructor(private actions$: Actions, private dataService: DataService) { }

    loadMovies$ = createEffect(() =>
        this.actions$.pipe(
            ofType(loadMovies),
            mergeMap(() =>
                this.dataService.getMovies().pipe(
                    map((movies) => {
                        return loadMoviesSuccess(movies)
                    }),
                    catchError((error) => of(loadMoviesFailure({ error })))
                )
            )
        )
    );
}
