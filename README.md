# docker-htmldiff

Htmldiff tool as a service

```
docker run -d -p 4567:4567 mcasimir/htmldiff
```

```
$ curl -w '\n' -d 'html1=<h1>foo</h1>&html2=<h1>bar</h1>' http://localhost:4567/diff
<h1><del class="diffmod">foo</del><ins class="diffmod">bar</ins></h1>
```

```
$ curl -X POST -F 'html1=@html1.html' -F 'html2=@html2.html' http://localhost:4567/diff
```
