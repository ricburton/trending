## (Unofficial) GitHub Trending API
#### _A tiny Ruby API for the trending repositories on GitHub_

Example request: http://githubtrending.herokuapp.com/trending?languages[]=ruby&languages[]=common-lisp&languages[]=python

Example response:


#####TODO
* Break apart the large fetch method
* Handle incorrect languages
* Accept 'all' as a language to return the overall leadboard
* Refresh the cache every hour using Heroku Scheduler
* Write a test suite