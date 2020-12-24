#!/bin/sh
curl 'https://s.42l.fr/' \
  -H 'authority: s.42l.fr' \
  -H 'pragma: no-cache' \
  -H 'cache-control: no-cache' \
  -H 'sec-ch-ua: "Google Chrome";v="87", " Not;A Brand";v="99", "Chromium";v="87"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'dnt: 1' \
  -H 'upgrade-insecure-requests: 1' \
  -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36' \
  -H 'origin: null' \
  -H 'content-type: application/x-www-form-urlencoded' \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'sec-fetch-site: cross-site' \
  -H 'sec-fetch-mode: navigate' \
  -H 'sec-fetch-user: ?1' \
  -H 'sec-fetch-dest: document' \
  -H 'accept-language: en-GB,en-US;q=0.9,en;q=0.8' \
  -H 'cookie: rs-short-captcha=h8t%2FFUhwE2ZaburhmNdtOednkeot1WoI9LAdyMV8jK9Qyg1UDCRJFotX2z3km7JB6JJ%2F9PNNqwkHxHNZ5BxqJew%2FvA%3D%3D' \
  --data-raw 'url_to=http%3A%2F%2Fwww.example.com&url_from=ZAP%2BAND%2B1%3D1%2B--%2B&captcha=ZAP' \
  --compressed

xdg-open log.html
