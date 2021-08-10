# alfresco-webscripts
Collection of useful Alfresco Webscripts for Data Dictionary

## deletedUsers
This webscripts fetches all the user with no email in the database (supports +1,000 entries in one query) and then fetches all the documents per user that are affected by the document retention policy

## retentionCheck
This webscript retrieves all the documents affected by the document retention policy of a given user. The username must be input in the URL as a parameter
