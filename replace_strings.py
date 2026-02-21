import os
import glob

files = glob.glob('proto/a8/self_host/**/*.sn', recursive=True)
for f in files:
    enc = 'utf-8'
    try:
        with open(f, 'r', encoding='utf-8') as file:
            content = file.read()
    except UnicodeDecodeError:
        enc = 'utf-16'
        with open(f, 'r', encoding='utf-16') as file:
            content = file.read()
    
    if '"' in content:
        content = content.replace('"', '`')
        with open(f, 'w', encoding=enc) as file:
            file.write(content)
        print(f"Updated {f}")
print("Replaced all double quotes with backticks in self_host .sn files")
