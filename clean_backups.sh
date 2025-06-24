#!/bin/bash

# Clean up backup directories and configure .gitignore

echo "🧹 Cleaning up backup directories..."

# Remove backup directories from Git tracking (if they exist)
if git ls-files --error-unmatch backup_*/ >/dev/null 2>&1; then
    echo "📂 Removing backup directories from Git tracking..."
    git rm -r --cached backup_*/ 2>/dev/null || true
fi

# Create or update .gitignore
echo "📝 Updating .gitignore..."
if [ ! -f .gitignore ]; then
    touch .gitignore
fi

# Add backup patterns to .gitignore if not already present
if ! grep -q "backup_\*/" .gitignore; then
    echo "" >> .gitignore
    echo "# Backup directories" >> .gitignore
    echo "backup_*/" >> .gitignore
    echo "*.backup" >> .gitignore
    echo "backup/" >> .gitignore
fi

# Add common Ansible ignores if not present
if ! grep -q "ansible.log" .gitignore; then
    echo "" >> .gitignore
    echo "# Ansible specific" >> .gitignore
    echo "*.retry" >> .gitignore
    echo ".vault_pass*" >> .gitignore
    echo "ansible.log" >> .gitignore
    echo "*.log" >> .gitignore
fi

# Optionally remove physical backup directories
read -p "🗑️  Delete backup directories from filesystem? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf backup_*/
    echo "✅ Backup directories deleted from filesystem"
else
    echo "📁 Backup directories kept on filesystem (but hidden from Git)"
fi

# Stage and commit changes
if git diff --cached --quiet; then
    echo "ℹ️  No changes to commit"
else
    git add .gitignore
    git commit -m "Add .gitignore rules to hide backup directories"
    echo "✅ Changes committed to Git"
fi

echo ""
echo "🎉 Cleanup complete!"
echo "📋 Summary:"
echo "   - Backup directories hidden from Git"
echo "   - .gitignore updated with Ansible best practices"
echo "   - Future backups will be automatically ignored"
