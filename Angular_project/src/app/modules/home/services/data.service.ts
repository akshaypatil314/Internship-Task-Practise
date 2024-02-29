import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, catchError, throwError } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class DataService {

  private readonly API_URL = 'https://reactnative.dev/movies.json';

  constructor(private http: HttpClient) { }

  getMovies(): Observable<any> {
    return this.http.get<any>(this.API_URL).pipe(
      catchError((error) => {
        console.log(error)
        return throwError('Error occurerd while fetching data');
      })
    );
  }
}
