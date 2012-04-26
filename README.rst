Reddit Crawler
==============

Deps
----

Just run::

    $ make deps

and it will install the required modules.


Run
---

Complete the ``RedditRIL.conf`` file with your credentials and the subreddit(s) and keywords you want to follow.

For example, if my name is *John* and my pass is *doe* and, I want to look up in */r/linux* for keywords *debian* and *ubuntu*, i'll write::

    credentials: [john, doe]
    linux: [debian, ubuntu]
