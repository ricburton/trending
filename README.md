## (Unofficial) GitHub Trending API
#### _A tiny Ruby API for the trending repositories on GitHub_

Example request: http://githubtrending.herokuapp.com/trending?languages[]=ruby&languages[]=common-lisp&languages[]=python

Example response:

    {
       "ruby":[
          {
             "rank":"#1",
             "title":"mroth/lolcommits",
             "description":"Takes a snapshot with your webcam every time you git commit code, and archives a lolcat style image with it."
          },
          {
             "rank":"#2",
             "title":"krisleech/wisper",
             "description":"Wisper is a Ruby library for decoupling and managing the dependencies of your domain models."
          }
          # until rank #25
       ],
       "common-lisp":[
          {
             "rank":"#1",
             "title":"google/lisp-koans",
             "description":"Common Lisp Koans is a language learning exercise in the same vein as the ruby koans, python koans and others.   It is a port of the prior koans with some modifications to highlight lisp-specific features.  Structured as ordered groups of broken unit tests, the project guides the learner progressively through many Common Lisp language features. "
          },
          {
             "rank":"#2",
             "title":"pallet/ritz",
             "description":"SWANK and nREPL servers for clojure providing JPDA based debuggers"
          }
          # ...
       ],
       "python":[
          {
             "rank":"#1",
             "title":"thekarangoel/Projects",
             "description":"Trying to complete over 100 projects in various categories in Python. Fork to learn any new language."
          },
          {
             "rank":"#2",
             "title":"python/raspberryio",
             "description":"Source code for raspberry.io"
          }
          # ...
       ]
    }

##### TODO
* Return the top trending repositories if no languages are specified in the request.
* Add a link to the README to the response.
