import sys
import re
from datetime import datetime
import subprocess

def update_pubspec(version):
    with open('pubspec.yaml', 'r', encoding='utf-8') as f:
        content = f.read()
    new_content = re.sub(r'version:\s*[^\n]+', f'version: {version}', content)
    with open('pubspec.yaml', 'w', encoding='utf-8') as f:
        f.write(new_content)
    print(f"Updated pubspec.yaml version to {version}")

def update_changelog(version, changelog):
    new_entry = f"## {version}\n\n{changelog.strip()}\n\n"
    with open('CHANGELOG.md', 'r', encoding='utf-8') as f:
        old_content = f.read()
    with open('CHANGELOG.md', 'w', encoding='utf-8') as f:
        f.write(new_entry + old_content)
    print(f"Prepended new changelog for {version}")

def git_commit_and_tag(version, changelog):
    subprocess.run(['git', 'add', 'pubspec.yaml', 'CHANGELOG.md'])
    commit_msg = f"chore(release): {version}\n\n{changelog.strip()}"
    subprocess.run(['git', 'commit', '-m', commit_msg])
    print("Committed changes to git.")

    # 推送 commit
    subprocess.run(['git', 'push'])
    print("Pushed commit to remote.")

    # 打 tag
    tag_name = f"v{version}"
    subprocess.run(['git', 'tag', tag_name])
    print(f"Created tag {tag_name}.")

    # 推送 tag
    subprocess.run(['git', 'push', 'origin', tag_name])
    print(f"Pushed tag {tag_name} to remote.")

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("Usage: python publish.py <version> <changelog>")
        print("Example: python publish.py 0.0.5 'Added new feature.'")
        sys.exit(1)
    version = sys.argv[1]
    changelog = sys.argv[2]
    update_pubspec(version)
    update_changelog(version, changelog)
    git_commit_and_tag(version, changelog)