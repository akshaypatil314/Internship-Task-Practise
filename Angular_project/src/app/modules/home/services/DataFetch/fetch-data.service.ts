import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable, Subject, catchError, map, tap, throwError } from 'rxjs';

interface Movie {
  id: string;
  title: string;
  description: string;
}

@Injectable({
  providedIn: 'root'
})
export class FetchDataService {

  private moviesSubject: BehaviorSubject<Movie[]> = new BehaviorSubject<Movie[]>([]);
  public movies$: Observable<Movie[]> = this.moviesSubject.asObservable();

  url: string = "https://reactnative.dev/movies.json";


  private readonly localStorageKey = 'moviesData';

  constructor(private http: HttpClient) {
    this.fetchMovies();
  }

  // private fetchMovies(): void {
  //   this.http.get<Movie[]>(this.url)
  //     .subscribe((data: any) => {
  //       this.moviesSubject.next(data.movies);
  //     });
  // }

  private fetchMovies(): void {
    const storedData = localStorage.getItem(this.localStorageKey);
    if (storedData) {
      const movies = JSON.parse(storedData);
      this.moviesSubject.next(movies);
    } else {
      this.http.get<Movie[]>(this.url)
        .pipe(
          tap((data: any) => {
            this.moviesSubject.next(data.movies);
            this.saveDataToLocalStorage(data.movies);
          }),
          catchError(error => {
            console.error('Error fetching movies', error);
            return [];
          })
        )
        .subscribe();
    }
  }


  getMovieList(): Observable<Movie[]> {
    return this.movies$;
  }

  private saveDataToLocalStorage(movies: Movie[]): void {
    localStorage.setItem(this.localStorageKey, JSON.stringify(movies));
  }

  getMovieById(id: number): Observable<{ id: string, title: string, releaseYear: string } | undefined> {
    return this.moviesSubject.asObservable().pipe(
      map((movies: any) => movies.find((movie: any) => movie.id === id))
    );
  }
}
