# alfresco-webscripts
Collection of useful Alfresco Webscripts for Data Dictionary

## deletedUsers
This webscripts fetches all the user with no email in the database (supports +1,000 entries in one query) and then fetches all the documents per user that are affected by the document retention policy

## deletedUsers 2.0
Reverse version of the original deletedUsers webscript, this time it fetches all the retained documents first, then checks if each owner/creator of the document has the email set, this is done to retrieve documents belonging to users that were deleted from the DB and therefore can not be found by querying the users.

## retentionCheck
This webscript retrieves all the documents affected by the document retention policy of a given user. The username must be input in the URL as a parameter, otherwise it will show your current logged user in Alfresco

## closureDate
Closure Date is a Script (not a webscript) that changes the date of closure when triggered. First, it checks if the folder has the Closure Date aspect, then, if the description of that folder is an integer, it changes the closure date property to today's date + the description number in years.

## secondParent
Second Parent webscript allows you to add a node (folder or document) as a child of another node (parent), since Alfresco allows multiple parents for one node, you will see the child is referenced in multiple places, but only exists in one place, it's a better alternative for shortcuts. This webscript will also allow you to remove child associations between nodes, although you can't remove a parent-child association between a primary parent node and a child node, otherwise the child node will become orphan and eventually removed from the system.
