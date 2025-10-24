#!/bin/bash

echo "Upgrading all migration files from Liquibase 1.9 to 2.0..."

# Update schema version in all migration files
find core/src/main/resources/migration -name "*.xml" -type f | while read file; do
    echo "Processing: $file"
    
    # Update schema version from 1.9 to 2.0
    sed -i '' 's|xmlns="http://www.liquibase.org/xml/ns/dbchangelog/1.9"|xmlns="http://www.liquibase.org/xml/ns/dbchangelog"|g' "$file"
    sed -i '' 's|http://www.liquibase.org/xml/ns/dbchangelog/1.9|http://www.liquibase.org/xml/ns/dbchangelog|g' "$file"
    sed -i '' 's|dbchangelog-1.9.xsd|dbchangelog-2.0.xsd|g' "$file"
    
    # Fix modifyColumn syntax to modifyDataType
    if grep -q '<modifyColumn tableName=' "$file"; then
        echo "  Fixing modifyColumn syntax in: $file"
        # Replace <modifyColumn tableName="table"><column name="col" type="TYPE"></column></modifyColumn>
        # with <modifyDataType tableName="table" columnName="col" newDataType="TYPE"/>
        sed -i '' -E 's|<modifyColumn tableName="([^"]*)">\s*<column name="([^"]*)" type="([^"]*)"></column>\s*</modifyColumn>|<modifyDataType tableName="\1" columnName="\2" newDataType="\3"/>|g' "$file"
    fi
done

echo "Migration files upgrade complete!"
