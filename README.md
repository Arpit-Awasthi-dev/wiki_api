# test_wiki_assign

Simple Flutter application with two page:-
1) Search Page - Uses Wiki search api
2) Detail Page - Uses Wiki TextExtracts API

# Api used
# 1 - Search Api
https://en.wikipedia.org//w/api.php?
action=query&
format=json&
prop=pageimages|pageterms&
generator=prefixsearch&
redirects=1&
formatversion=2&
piprop=thumbnail&
pithumbsize=50&
pilimit=max&
wbptterms=description&
gpssearch=red fort &
gpslimit=max

# 2 - Wiki TextExtracts API
https://en.wikipedia.org/w/api.php?
action=query&
format=json&
prop=extracts&
titles=India&
formatversion=2&
exsentences=10&
exlimit=1&
explaintext=1