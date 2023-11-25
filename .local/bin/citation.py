#!/usr/bin/env python3

import requests
import random
from colorama import Fore, Style
from bs4 import BeautifulSoup

URL = "https://www.mon-poeme.fr/citation-du-jour/"

response = requests.get(URL)
content = response.content
soup = BeautifulSoup(content, "html.parser")

blockquote = soup.find_all('blockquote')
figcaption = soup.find_all('figcaption')

cs = zip(
    map(lambda x: x.p.span.text, blockquote),
    map(lambda x: (x.span.a.text, x.span.cite.text), figcaption),
)

c = random.choice(list(cs))

print(f"{Style.BRIGHT}{c[0]}{Style.RESET_ALL}")
print(f"{Style.DIM}~ {c[1][0]} « {c[1][1]} »{Style.RESET_ALL}")
