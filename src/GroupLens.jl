module GroupLens
using DataDeps

export @datadep_str

function __init__()
    register(DataDep("MovieLens-latest",
        """
        DataSet: Latest extract of data from MovieLens
        Source: GroupLens project at U. of Minnesota
        Website: https://grouplens.org/datasets/movielens/latest/

        Movie ratings from the MovieLens web site.  This data set contains about 27,000,000 ratings
        and 1,100,000 tag applications applied to 58,000 movies by 280,000 users.
        """,
        "http://files.grouplens.org/datasets/movielens/ml-latest.zip",
        "b9c23b665ee348bd1fadfadca688b8750c575f3af76d3441cd50cba87ad2c4df",
        post_fetch_method=unpack
    ))
    register(DataDep("MovieLens-latest-small",
        """
        DataSet: Latest small extract of data from MovieLens
        Source: GroupLens project at U. of Minnesota
        Website: https://grouplens.org/datasets/movielens/latest/

        100,000 ratings and 3,600 tag applications applied to 9,000 movies by 600 users.
        Last updated 9/2018.
        """,
        "http://files.grouplens.org/datasets/movielens/ml-latest-small.zip",
        "696d65a3dfceac7c45750ad32df2c259311949efec81f0f144fdfb91ebc9e436",
        post_fetch_method=unpack
    ))
    register(DataDep("MovieLens-20m",
        """
        DataSet: Stable benchmark dataset from MovieLens
        Source: GroupLens project at U. of Minnesota
        Website: https://grouplens.org/datasets/movielens/20m/

        Stable benchmark dataset. 20 million ratings and 465,000 tag applications applied
        to 27,000 movies by 138,000 users. Includes tag genome data with 12 million
        relevance scores across 1,100 tags. 
        Released 4/2015; 
        updated 10/2016 to update links.csv and add tag genome data.
        """,
        "http://files.grouplens.org/datasets/movielens/ml-20m.zip",
        "96f243c338a8665f6bcc89c53edf6ee39162a846940de6b7c8c48aeada765ff3",
        post_fetch_method=unpack
    ))
    register(DataDep("Book-Crossing",
        """
        DataSet: Book ratings from the Book-Crossing community
        Source: Cai-Nicolas Ziegler at DBIS Freiberg
        Website: http://www2.informatik.uni-freiburg.de/~cziegler/BX/

        Collected by Cai-Nicolas Ziegler in a 4-week crawl (August / September 2004)
        from the Book-Crossing community with kind permission from Ron Hornbaker,
        CTO of Humankind Systems. Contains 278,858 users (anonymized but with demographic
        information) providing 1,149,780 ratings (explicit / implicit) about 271,379 books. 
        """,
        "http://www2.informatik.uni-freiburg.de/~cziegler/BX/BX-CSV-Dump.zip",
        "adc7b47afb47c8e29e5f0b70a9816569b3367c5588064ba7a916f16e3ef5d060",
        post_fetch_method=unpack
    ))
    register(DataDep("MovieLens-20m-trailers",
        """
        DataSet: Links to YouTube IDs for trailers for movies in MovieLens-20m
        Source: GroupLens project at U. of Minnesota
        Website: https://grouplens.org/datasets/movielens/20m-youtube/

        This amendment to the MovieLens 20M Dataset is a CSV file that maps
        MovieLens Movie IDs to YouTube IDs representing movie trailers.
        It contains 25,623 YouTube IDs. 
        Released 5/2018.
        """,
        "http://files.grouplens.org/datasets/movielens/ml-20m-youtube.zip",
        "7f2fbf681afeec7b50c91b739885fcee4ed8c9c7ba43358a38f094e095eccb5d",
        post_fetch_method=unpack
    ))

end

end # module
