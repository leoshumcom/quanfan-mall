#!/bin/bash
set -e
cd /opt
echo "=== Upgrade Maven ==="
curl -fsSL https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz -o /tmp/maven.tar.gz 2>&1 | tail -3
tar -xzf /tmp/maven.tar.gz -C /opt/
rm -f /usr/bin/mvn
ln -sf /opt/apache-maven-3.9.9/bin/mvn /usr/bin/mvn
echo "Maven version:"
mvn --version 2>&1 | head -2
echo "=== Maven upgrade done ==="
