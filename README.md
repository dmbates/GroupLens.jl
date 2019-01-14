# Access data from the GroupLens project

Use [`DataDeps`](https://github.com/oxinabox/DataDeps.jl) and
[`JuliaDB`](https://github.com/JuliaComputing/JuliaDB.jl)
to access [GroupLens project](https://grouplens.org) datasets.

This package registers `DataDep`s for datasets named 
[MovieLens-latest](https://grouplens.org/datasets/movielens/latest/),
[MovieLens-latest-small](https://grouplens.org/datasets/movielens/latest/),
[MovieLens-20m](https://grouplens.org/datasets/movielens/20m/),
[MovieLens-20m-trailers](https://grouplens.org/datasets/movielens/20m-youtube/), and
[Book-Crossing](http://www2.informatik.uni-freiburg.de/~cziegler/BX/).

To access a particular dataset, use the `datadep` string macro.  The first time you
access the dataset it will be downloaded and the `.zip` file expanded.  Subsequent usages will access the locally cached files.
```julia
julia> using Dates, GroupLens, JuliaDB

julia> readdir(datadep"MovieLens-20m")
This program has requested access to the data dependency MovieLens-20m.
which is not currently installed. It can be installed automatically, and you will not see this message again.

DataSet: Stable benchmark dataset from MovieLens
Source: GroupLens project at U. of Minnesota
Website: https://grouplens.org/datasets/movielens/20m/

Stable benchmark dataset. 20 million ratings and 465,000 tag applications applied
to 27,000 movies by 138,000 users. Includes tag genome data with 12 million
relevance scores across 1,100 tags.
Released 4/2015;
updated 10/2016 to update links.csv and add tag genome data.



Do you want to download the dataset from http://files.grouplens.org/datasets/movielens/ml-20m.zip to "/home/bates/.julia/datadeps/MovieLens-20m"?
[y/n]
y
┌ Info: Downloading
│   source = "http://files.grouplens.org/datasets/movielens/ml-20m.zip"
│   dest = "/home/bates/.julia/datadeps/MovieLens-20m/ml-20m.zip"
│   progress = 1.0
│   time_taken = "2.72 s"
│   time_remaining = "0.0 s"
│   average_speed = "69.771 MiB/s"
│   downloaded = "189.497 MiB"
│   remaining = "0 bytes"
└   total = "189.497 MiB"
Archive:  /home/bates/.julia/datadeps/MovieLens-20m/ml-20m.zip
   creating: /home/bates/.julia/datadeps/MovieLens-20m/ml-20m/
  inflating: /home/bates/.julia/datadeps/MovieLens-20m/ml-20m/genome-scores.csv
  inflating: /home/bates/.julia/datadeps/MovieLens-20m/ml-20m/genome-tags.csv
  inflating: /home/bates/.julia/datadeps/MovieLens-20m/ml-20m/links.csv
  inflating: /home/bates/.julia/datadeps/MovieLens-20m/ml-20m/movies.csv
  inflating: /home/bates/.julia/datadeps/MovieLens-20m/ml-20m/ratings.csv
  inflating: /home/bates/.julia/datadeps/MovieLens-20m/ml-20m/README.txt
  inflating: /home/bates/.julia/datadeps/MovieLens-20m/ml-20m/tags.csv
1-element Array{String,1}:
 "ml-20m"
```

A convenient way to access these data tables is with `loadtable` from the `JuliaDB` package.
```
julia> links = loadtable(datadep"MovieLens-20m/ml-20m/links.csv", indexcols=[1],
           colparsers=[Int32, Int32, Int32])
Table with 27278 rows, 3 columns:
movieId  imdbId   tmdbId
────────────────────────
1        114709   862
2        113497   8844
3        113228   15602
4        114885   31357
5        113041   11862
6        113277   949
7        114319   11860
8        112302   45325
⋮
131252   289477   9677
131254   466713   4436
131256   277703   9274
131258   3485166  285213
131260   249110   32099
131262   1724965  286971


julia> movies = loadtable(datadep"MovieLens-20m/ml-20m/movies.csv", indexcols=[1],
           colparsers=[Int32,String,String])
Table with 27278 rows, 3 columns:
movieId  title                                                     genres
────────────────────────────────────────────────────────────────────────────────────────────────────────────────
1        "Toy Story (1995)"                                        "Adventure|Animation|Children|Comedy|Fantasy"
2        "Jumanji (1995)"                                          "Adventure|Children|Fantasy"
3        "Grumpier Old Men (1995)"                                 "Comedy|Romance"
4        "Waiting to Exhale (1995)"                                "Comedy|Drama|Romance"
5        "Father of the Bride Part II (1995)"                      "Comedy"
6        "Heat (1995)"                                             "Action|Crime|Thriller"
7        "Sabrina (1995)"                                          "Comedy|Romance"
8        "Tom and Huck (1995)"                                     "Adventure|Children"
⋮
131252   "Forklift Driver Klaus: The First Day on the Job (2001)"  "Comedy|Horror"
131254   "Kein Bund für's Leben (2007)"                            "Comedy"
131256   "Feuer, Eis & Dosenbier (2002)"                           "Comedy"
131258   "The Pirates (2014)"                                      "Adventure"
131260   "Rentun Ruusu (2001)"                                     "(no genres listed)"
131262   "Innocence (2014)"                                        "Adventure|Fantasy|Horror"


julia> ratings = loadtable(datadep"MovieLens-20m/ml-20m/ratings.csv", indexcols=[1,2],
           colparsers=[Int32,Int32,Float32,Int]);

julia> ratings = setcol(ratings, :timestamp, :timestamp => unix2datetime)
Table with 20000263 rows, 4 columns:
userId  movieId  rating  timestamp
────────────────────────────────────────────
1       2        3.5     2005-04-02T23:53:47
1       29       3.5     2005-04-02T23:31:16
1       32       3.5     2005-04-02T23:33:39
1       47       3.5     2005-04-02T23:32:07
1       50       3.5     2005-04-02T23:29:40
1       112      3.5     2004-09-10T03:09:00
1       151      4.0     2004-09-10T03:08:54
1       223      4.0     2005-04-02T23:46:13
⋮
138493  68319    4.5     2009-12-07T18:15:20
138493  68954    4.5     2009-11-13T15:42:00
138493  69526    4.5     2009-12-03T18:31:48
138493  69644    3.0     2009-12-07T18:10:57
138493  70286    5.0     2009-11-13T15:42:24
138493  71619    2.5     2009-10-17T20:25:36
```

