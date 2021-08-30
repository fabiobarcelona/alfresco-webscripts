# alfresco-webscripts
Collection of useful Alfresco Webscripts for Data Dictionary

## deletedUsers
This webscripts fetches all the user with no email in the database (supports +1,000 entries in one query) and then fetches all the documents per user that are affected by the document retention policy

## deletedUsers 2.0
Reverse version of the original deletedUsers webscript, this time it fetches all the retained documents first, then checks if each owner/creator of the document has the email set, this is done to retrieve documents belonging to users that were deleted from the DB and therefore can not be found by querying the users.

## retentionCheck
This webscript retrieves all the documents affected by the document retention policy of a given user. The username must be input in the URL as a parameter, otherwise it will show your current logged user in Alfresco
