import os
import glob
import re

files = glob.glob('proto/a9/self_host/**/*.sn', recursive=True)

for filepath in files:
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        enc = 'utf-8'
    except UnicodeDecodeError:
        with open(filepath, 'r', encoding='utf-16') as f:
            content = f.read()
        enc = 'utf-16'
    
    # Replace single character backticks with backslashes
    content = re.sub(r'`(.)`', r'\\\1', content)
    
    # Replace 4 spaces with tabs
    lines = content.split('\n')
    new_lines = []
    for line in lines:
        if line.startswith(' '):
            spaces = len(line) - len(line.lstrip(' '))
            tabs = spaces // 4
            new_lines.append('\t' * tabs + line.lstrip(' '))
        else:
            new_lines.append(line)
            
    with open(filepath, 'w', encoding=enc) as f:
        f.write('\n'.join(new_lines))

print("Fixed backticks and indentation in proto/a9/self_host files.")
