So basically we just followed [this simple and concise tutorial](http://www.forensicswiki.org/wiki/Mozilla_Firefox).

```
cts@csaw:~/places-30/fk1onhl4.default$ sqlite3
SQLite version 3.11.0 2016-02-15 17:29:24
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
sqlite> .open places.sqlite
sqlite> SELECT datetime(moz_historyvisits.visit_date/1000000, 'unixepoch', 'localtime'), moz_places.url FROM moz_places, moz_historyvisits WHERE moz_places.id = moz_historyvisits.place_id;
2017-09-15 17:06:08|https://www.mozilla.org/en-US/firefox/55.0.3/firstrun/
2017-09-15 17:06:08|https://www.mozilla.org/privacy/firefox/
2017-09-15 17:06:09|https://www.mozilla.org/en-US/privacy/firefox/
2017-09-15 19:04:38|https://search.yahoo.com/yhs/search?p=gopher+client&ei=UTF-8&hspart=mozilla&hsimp=yhs-001
2017-09-15 19:04:57|https://search.yahoo.com/yhs/search?p=gopher+client&ei=UTF-8&hspart=mozilla&hsimp=yhs-001
2017-09-15 19:04:40|http://google.com/
2017-09-15 19:04:40|http://www.google.com/
2017-09-15 19:04:40|https://www.google.com/?gws_rd=ssl
2017-09-15 19:04:42|https://www.google.com/search?source=hp&q=gopher+client&oq=gopher+client&gs_l=psy-ab.3..0l3j0i22i30k1.487.1352.0.1432.13.9.0.0.0.0.89.704.9.9.0.foo%2Cnso-ehuqi%3D1%2Cnso-ehuui%3D1%2Cewh%3D0%2Cnso-mplt%3D2%2Cnso-enksa%3D0%2Cnso-enfk%3D1%2Cnso-usnt%3D1%2Cnso-qnt-npqp%3D0-1633%2Cnso-qnt-npdq%3D0-5608%2Cnso-qnt-npt%3D0-1229%2Cnso-qnt-ndc%3D2051%2Ccspa-dspm-nm-mnp%3D0-06145%2Ccspa-dspm-nm-mxp%3D0-153625%2Cnso-unt-npqp%3D0-1506%2Cnso-unt-npdq%3D0-4694%2Cnso-unt-npt%3D0-061%2Cnso-unt-ndc%3D300%2Ccspa-uipm-nm-mnp%3D0-007625%2Ccspa-uipm-nm-mxp%3D0-053375%2Ccfro%3D1...0...1.1.64.psy-ab..4.9.697...0i131k1j0i10k1.0.JvUH6kQcCOA
2017-09-15 19:04:45|https://www.google.com/search?q=gopher+client+firefox+&oq=gopher+client+firefox+&gs_l=psy-ab.3..0l2j0i30k1l2.63.1559.0.1615.17.12.2.0.0.0.139.804.4j4.8.0.foo%2Cnso-ehuqi%3D1%2Cnso-ehuui%3D1%2Cewh%3D0%2Cnso-mplt%3D2%2Cnso-enksa%3D0%2Cnso-enfk%3D1%2Cnso-usnt%3D1%2Cnso-qnt-npqp%3D0-1633%2Cnso-qnt-npdq%3D0-5608%2Cnso-qnt-npt%3D0-1229%2Cnso-qnt-ndc%3D2051%2Ccspa-dspm-nm-mnp%3D0-06145%2Ccspa-dspm-nm-mxp%3D0-153625%2Cnso-unt-npqp%3D0-1506%2Cnso-unt-npdq%3D0-4694%2Cnso-unt-npt%3D0-061%2Cnso-unt-ndc%3D300%2Ccspa-uipm-nm-mnp%3D0-007625%2Ccspa-uipm-nm-mxp%3D0-053375%2Ccfro%3D1...0...1.1.64.psy-ab..12.4.185...0i13k1j0i13i30k1j0i7i30k1.br9sQoaXoA4
2017-09-15 19:04:47|https://addons.mozilla.org/en-US/firefox/addon/overbiteff/
2017-09-15 19:04:59|https://search.yahoo.com/yhs/search;_ylt=A0LEV7mZXLxZNhwAH_InnIlQ;_ylc=X1MDMTM1MTE5NTY4NwRfcgMyBGZyA3locy1tb3ppbGxhLTAwMQRncHJpZANzaXVwWU1RSlRtYWk0RHg4Ymt2NkVBBG5fcnNsdAMwBG5fc3VnZwM0BG9yaWdpbgNzZWFyY2gueWFob28uY29tBHBvcwMwBHBxc3RyAwRwcXN0cmwDMARxc3RybAMyMgRxdWVyeQNnb3BoZXIlMjBjbGllbnQlMjBicmV3BHRfc3RtcAMxNTA1NTE2Njk5?p=gopher+client+brew&fr2=sb-top&hspart=mozilla&hsimp=yhs-001
2017-09-15 19:05:02|https://github.com/prologic/gopherclient
2017-09-15 19:09:09|http://vielmetti.typepad.com/vacuum/2014/10/brew-install-lynx-and-then-gopher-lives-on.html
2017-09-15 19:10:34|https://search.yahoo.com/yhs/search?p=gopher+request&ei=UTF-8&hspart=mozilla&hsimp=yhs-002
2017-09-15 19:16:43|https://search.yahoo.com/yhs/search?p=gopher+request&ei=UTF-8&hspart=mozilla&hsimp=yhs-002
2017-09-15 19:10:36|https://en.wikipedia.org/wiki/Gopher_(protocol)
2017-09-15 19:10:57|https://search.yahoo.com/yhs/search?p=gopher+index&ei=UTF-8&hspart=mozilla&hsimp=yhs-002
2017-09-15 19:16:48|https://tools.ietf.org/search/rfc1436
2017-09-15 19:17:27|https://search.yahoo.com/yhs/search?p=carriage+return+code&ei=UTF-8&hspart=mozilla&hsimp=yhs-002
2017-09-15 19:17:28|http://www.theasciicode.com.ar/ascii-control-characters/carriage-return-ascii-code-13.html
2017-09-15 19:17:32|https://stackoverflow.com/questions/12747722/what-is-the-difference-between-a-line-feed-and-a-carriage-return
2017-09-15 19:23:39|https://search.yahoo.com/yhs/search?p=connection+close+golang&ei=UTF-8&hspart=mozilla&hsimp=yhs-002
2017-09-15 19:23:41|https://golang.org/pkg/net/
2017-09-15 19:23:44|https://golang.org/pkg/net/#IPConn.Close
2017-09-21 00:33:06|http://ownforall.hsf.csaw.io/
2017-09-21 00:33:08|http://ownforall.hsf.csaw.io/clearsoc.html
2017-09-21 00:37:19|https://search.yahoo.com/yhs/search?p=flag%7Bshhh_we_n3eded_the_story_to_continue%7D%09&ei=UTF-8&hspart=mozilla&hsimp=yhs-002
2017-09-21 01:19:23|http://clearsoc.hsf.csaw.io/
2017-09-21 01:19:30|http://clearsoc.hsf.csaw.io/login
sqlite>
```

We see the urlencoded flag: `flag%7Bshhh_we_n3eded_the_story_to_continue%7D`.

`flag{shhh_we_n3eded_the_story_to_continue}`
