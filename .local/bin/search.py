#!/usr/bin/env python3

import argparse
import os

SEARX = "https://searxng.earth2077.fr/search?q=%s"
INVIDIOUS = "https://invidious.earth2077.fr/search?q=%s"
GITHUB = "https://github.com/search?q=%s&type=repositories"
FORGEJO = "https://git.earth2077.fr/explore/repos?sort=recentupdate&language=&q=%s&only_show_relevant=false"
WIKIPEDIA = "https://wikipedia.org/w/index.php?search=%s"
YANDEX = "https://yandex.com/search?text=%s"
GENIUS = "https://genius.com/search?q=%s"
HOOGLE = "https://hoogle.haskell.org/?hoogle=%s"


parser = argparse.ArgumentParser(description="Search the web, simply")
parser.add_argument("-m", "--motor", type=str, nargs=1, help="motor")
parser.add_argument("query", type=str, nargs="*", help="query")

args = parser.parse_args()


motor = ""
if not args.motor:
    motor = SEARX
else:
    match args.motor[0]:
        case "yt":
            motor = INVIDIOUS
        case "fg":
            motor = FORGEJO
        case "gh":
            motor = GITHUB
        case "wk":
            motor = WIKIPEDIA
        case "yd":
            motor = YANDEX
        case "ge":
            motor = GENIUS
        case "hg":
            motor = HOOGLE
        case _:
            motor = SEARX

query = " ".join(args.query).replace(" ", "%20")
link = motor[:].replace("%s", query)

# make the system go
print(link)
os.system(f"open {link}")
