#!/usr/bin/env python3

import argparse
import os

SEARX = "https://searxng.earth2077.fr/search?q={query}"
INVIDIOUS = "https://invidious.earth2077.fr/search?q={query}"
GITHUB = "https://github.com/search?q={query}&type=repositories"
FORGEJO = "https://git.earth2077.fr/?repo-search-query={query}"


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
        case "fj":
            motor = FORGEJO
        case "gh":
            motor = GITHUB
        case _:
            motor = SEARX

query = " ".join(args.query).replace(" ", "%20")


link = motor[:].replace("{query}", query)
os.system(f"open {link}")
