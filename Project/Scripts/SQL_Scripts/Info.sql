SELECT TABLE_SCHEMA + '.' + TABLE_NAME AS Name
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_CATALOG='AMDB'
ORDER BY Name
