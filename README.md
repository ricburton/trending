## (Unofficial) GitHub Trending API
#### _A tiny Ruby API for the trending repositories on GitHub_

This API powers a little iPhone app I'm working called [Repo](https://github.com/richardburton/Repo). It shows you the trending repositories that are built with the languages you love.

Example request: http://githubtrending.herokuapp.com/trending?languages[]=ruby&languages[]=objective-c

Example response:

<<<<<<< HEAD
{
  "ruby": [
    {
      "rank": "#1",
      "title": "gitlabhq/gitlabhq",
      "description": "Project management and code hosting  application. Follow us on twitter @gitlabhq",
      "repo_url": "http://www.github.com/gitlabhq/gitlabhq"
    },
    {
      "rank": "#2",
      "title": "square/apropos",
      "description": "A simple way to serve up appropriate images for every visitor.",
      "repo_url": "http://www.github.com/square/apropos"
    } # Until #25
  ],
  "objective-c": [
    {
      "rank": "#1",
      "title": "nicolaschengdev/WYPopoverController",
      "description": "WYPopoverController is for the presentation of content in popover on iPhone / iPad devices. Very customizable.",
      "repo_url": "http://www.github.com/nicolaschengdev/WYPopoverController"
    },
    {
      "rank": "#2",
      "title": "alobi/ALAlertBanner",
      "description": "A clean and simple alert banner for iPhone and iPad",
      "repo_url": "http://www.github.com/alobi/ALAlertBanner"
    } # Until #25
  ]
}

#####TODO
* Break apart the large fetch method
* Handle incorrect languages
* Accept 'all' as a language to return the overall leadboard
* Refresh the cache every hour using Heroku Scheduler
* Write a test suite
