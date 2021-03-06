+++
title = "[PukiWiki:wiki] BSD/FreeBSD/Tinderbox/Memo"
date = "2009-10-01T07:08:56Z"
+++

# tcスクリプトのオプション一覧  {#w7413bff}

```
Setup
        Set up a new Tinderbox
Upgrade
        Upgrade an existing Tinderbox
addBuild
        Add a build to the datastore
addBuildPortsQueueEntry
        Adds a Port to the Ports to Build Queue
addBuildUser
        Add a user to a given build's interest list
addJail
        Add a jail to the datastore
addPort
        Add a port to the datastore
addPortFailPattern
        Add a port failure pattern to the datastore
addPortFailReason
        Add a port failure reason to the datastore
addPortToOneBuild
        INTERNAL function only
addPortsTree
        Add a portstree to the datastore
addUser
        Add a user to the datastore
configCcache
        Configure Tinderbox ccache parameters
configDistfile
        Configure Tinderbox distfile parameters
configGet
        Print current Tinderbox configuration
configHost
        Configure Tinderbox Host parameters
configOptions
        Configure Tinderbox port OPTIONS parameters
configPackage
        Configure Tinderbox package parameters
configTinderd
        Configure Tinderbox tinder daemon (tinderd) parameters
copyBuild
        Copy the environment and ports from one build to another
copyBuildPorts
        Copy the ports from one build to another
createBuild
        Create a new build
createJail
        Create a new jail
createPortsTree
        Create a new portstree
dsversion
        Print the datastore version
dumpObject
        Dump the contents of a TinderObject
getDependenciesForPort
        Get stored dependencies for a given port and build
getHookCmd
        Get the command for a given hook
getJailArch
        Get the architecture for a give jail
getJailForBuild
        Get the jail name associated with a given build
getPackageSuffix
        Get the package suffix for a given jail
getPortLastBuiltStatus
        Get the last built status for the specified port and build
getPortLastBuiltVersion
        Get the last built version for the specified port and build
getPortTotalSize
        Get the total size (in KB) required for the specified port and
        build
getPortsForBuild
        Get all the ports associated with a given build
getPortsMount
        Get the ports mount source for the given portstree
getPortsTreeForBuild
        Get the portstree name assoicated with a given build
getSrcMount
        Get the src mount source for the given jail
getTagForJail
        Get the tag for a given jail
getUpdateCmd
        Get the update command for the given object
init
        Initialize a tinderbox environment
isLogCurrent
        Determine if a logfile is still relevant
listBuildPortsQueue
        Lists the Ports to Build Queue
listBuildUsers
        List all users in the interest list for a build
listBuilds
        List all builds in the datastore
listHooks
        List all hooks, their commands, and their descriptions
listJails
        List all jails in the datastore
listPortFailPatterns
        List all port failure patterns, their reasons, and regular
        expressions
listPortFailReasons
        List all port failure reasons and their descriptions
listPorts
        List all ports in the datastore
listPortsTrees
        List all portstrees in the datastore
listUsers
        List all users in the datastore
makeBuild
        Populate a build prior to tinderbuild
makeJail
        Update and build an existing jail
processLog
        Analyze a logfile to find the failure reason
reorgBuildPortsQueue
        Reorganizes the Ports to Build Queue
rescanPorts
        Update properties for all ports in the datastore
resetBuild
        Cleanup and reset a Build environment
rmBuild
        Remove a build from the datastore
rmBuildPortsQueue
        Removes all Ports from the Ports to Build Queue
rmBuildPortsQueueEntry
        Removes a Port from the Ports to Build Queue
rmJail
        Remove a jail from the datastore
rmPort
        Remove a port from the datastore, and optionally its package
        and logs from the file system
rmPortFailPattern
        Remove a port failure pattern from the datastore
rmPortFailReason
        Remove a port failure reason from the datastore
rmPortsTree
        Remove a portstree from the datastore
rmUser
        Remove a user from the datastore
sendBuildCompletionMail
        Send email to the build interest list when a build completes
sendBuildErrorMail
        Send email to the build interest list when a port fails to
        build
setPortsMount
        Set the ports mount source for the given portstree
setSrcMount
        Set the src mount source for the given jail
setWwwAdmin
        Defines which user is the www admin
tbcleanup
        Cleanup old build logs, and prune old database entries for
        which no package exists
tbkill
        Kill a tinderbuild
tbversion
        Display Tinderbox version
tinderbuild
        Generate packages from an installed Build
updateBuildCurrentPort
        Update the port currently being built for the specify build
updateBuildPortsQueueEntryCompletionDate
        Update the specified Build Ports Queue Entry completion time
updateBuildPortsQueueEntryStatus
        Update the current status for the specific queue entry
updateBuildRemakeCount
        Update the count of number of ports needing a rebuild
updateBuildStatus
        Update the current status for the specific build
updateBuildUser
        Update email preferences for the given user for the given build
updateHookCmd
        Update the command for the given hook
updateJailLastBuilt
        Update the specified jail's last built time
updatePortFailReason
        Update the type or description of a port failure reason
updatePortStatus
        Update build information about a port
updatePortsTree
        Update an existing ports tree
updatePortsTreeLastBuilt
        Update the specified portstree's last built time
updateUser
        Update user preferences
```
