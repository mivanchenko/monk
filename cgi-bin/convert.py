#!/usr/bin/env python3

import glob
import markdown
import re
import subprocess

with open('tpl/header') as f:
    header = f.read()
with open('tpl/footer') as f:
    footer = f.read()

for src_path in glob.glob('src/*.md'):
    with open(src_path) as f:
        markdown_text = f.read()
    html = markdown.Markdown().convert(markdown_text)
    match = re.search('src/(.+).md', src_path)
    if match:
        dest_path = match.group(1)
    with open(dest_path, 'w') as f:
        f.write('\n'.join([header, html, footer]))

src_paths = subprocess.getoutput('find src/pestov | grep \.md\$').split()

for src_path in src_paths:
    with open(src_path) as f:
        markdown_text = f.read()
    html = markdown.Markdown().convert(markdown_text)
    dest_path = re.sub('^src/', '', src_path)
    dest_path = re.sub('index\.md$', 'index.html', dest_path)
    dest_path = re.sub('\.md$', '', dest_path)
    with open(dest_path, 'w') as f:
        f.write('\n'.join([header, html, footer]))
