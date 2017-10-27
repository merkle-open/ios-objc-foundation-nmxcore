#!/bin/sh
## Configuration
readmeFile="README.md"
podspecFilename="NMXCore"
readmePodPushHeader="Update cocoapod spec"
readmeVersionHeader="Current Version of the NMXCore Library"
version=$1


## constants & commands
podspecFile="${podspecFilename}.podspec"
podspecDylibFile="${podspecFilename}Dylib.podspec"
podPushCommand1="pod trunk push ${podspecFile} --verbose"
podPushCommand2="pod trunk push ${podspecDylibFile} --verbose"

modifiedFiles=$(git diff --name-only)
# Escape special characters for sed command
podPushCommandE1=$(printf '%q' "${podPushCommand1}")
podPushCommandE1=$(echo ${podPushCommandE1})
currentPodVersionCommand1=$(grep "s.version " ${podspecFile} -n | sed 's/.*"\(.*\)".*/\1/')
currentPodCommitIDCommand=$(grep ":commit" ${podspecFile} -n | sed 's/.*"\(.*\)".*/\1/')

podPushCommandE1=$(printf '%q' "${podPushCommand1}")
podPushCommandE1=$(echo ${podPushCommandE1})

currentPodVersionCommand2=$(grep "s.version " ${podspecDylibFile} -n | sed 's/.*"\(.*\)".*/\1/')
podPushCommandE2=$(printf '%q' "${podPushCommand2}")
podPushCommandE2=$(echo ${podPushCommandE2})

podLibLint1=$(pod lib lint ${podspecFile} 2>&1 | tail -1)
podLibLint2=$(pod lib lint ${podspecDylibFile} 2>&1 | tail -1)
podSpecLint1=$(pod spec lint ${podspecFile} 2>&1 | tail -2)
podSpecLint2=$(pod spec lint ${podspecDylibFile} 2>&1 | tail -2)


if [ "$version" == "" ]
then
version=$currentPodVersionCommand1
fi


## User output
printf "## Starting Deployment: ${podspecFile} and ${podspecDylibFile}##\n"
printf "## Validating Filechanges:\n"
if [ "$modifiedFiles" == "$podspecFile" ]
then
echo "all OK"
else
echo -e "Please commit or stash all your changes first, then update your podspec file!"
fi

printf "## Updating README.md file\n\n"
# find line of update command headline and increase by one
if [ "$readmeFile" != "" ]
then
lineNumber=$(grep "${readmePodPushHeader}" ${readmeFile} -n -i | sed 's/:.*//')
if [ "$lineNumber" == "" ]
then
printf "\n\n'pod repo push command' in ${readmeFile} could not be updated. Referenced header line:\n\t${readmePodPushHeader}\nwas not found.\nIf you want the following line:\n\t$(printf '%b' "${podPushCommand1}")\nbeing noted down, make sure to either add an appropriate abstract containing\n\t'${readmePodPushHeader}'\nor modify the variable\n\t'\$readmePodPushHeader' in 'deploy.sh'\n\n"
else
readmePodInstruction=$((lineNumber+1))
sed -i "" "${readmePodInstruction}s/.*/${podPushCommandE1}/" ${readmeFile}
fi

# Update current version in README
lineNumber=$(grep "${readmeVersionHeader}" ${readmeFile} -n -i | sed 's/:.*//')
if [ "$lineNumber" == "" ]
then
printf "\n\nCurrent 'Version' in ${readmeFile} could not be updated. Referenced header line:\n\t${readmeVersionHeader}\nwas not found.\nIf you want the current version:\n\t${version}\nbeing noted down, make sure to either add an appropriate abstract containing\n\t'${readmeVersionHeader}'\nor modify the variable\n\t'\$readmeVersionHeader' in 'deploy.sh'\n\n"
else
    readmeVersionLine=$((lineNumber+1))
    sed -i "" "${readmeVersionLine}s/.*/${version}/" ${readmeFile}
fi
fi

printf "## Preparing version ${version}\n...\n\n"


### Validate the libraries ###
printf "Running Tests for Static Library\n"
testStatic=$(xcodebuild -project Development/NMXCore.xcodeproj -scheme NMXCoreTestsStatic -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 8,OS=11.0' test 2>&1 | tail -2)
testsSucceeded="Test Suite 'All tests' passed "
if [ "${testStatic#*$testsSucceeded}" == "$testStatic" ]
then
    printf "Deployment failed, because tests don't pass\n"
    echo "${testStatic}"
    exit
else
    printf "Static tests passed\n"
fi
printf "\n"

printf "Running Tests for Dynamic Library\n"
testDylib=$(xcodebuild -project Development/NMXCore.xcodeproj -scheme NMXCoreTests -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 8,OS=11.0' test 2>&1 | tail -2)
testsSucceeded="Test Suite 'All tests' passed "
if [ "${testDylib#*$testsSucceeded}" == "$testDylib" ]
then
    printf "Deployment failed, because tests don't pass\n"
    exit
else
    printf "Dylib tests passed\n"
fi
printf "\n"

### Archiving Dynamic Lib ###
printf "Preparing Archive of Dynamic Library\n"
archiveCommand=$(xcodebuild -project ./Development/NMXCore.xcodeproj -scheme NMXCore archive 2>&1 | tail -2)
archiveSucceeded="** ARCHIVE SUCCEEDED **"
if [ "${archiveCommand#*$archiveSucceeded}" == "$archiveCommand" ]
then
printf "Archive Process failed\n"
exit
else
    # Ensure we successfully exported the latest Framework file!
    frameWorkFile="./Development/NMXCore.framework/Info.plist"
    dateComparison=$(($(date +%s) - $(stat -t %s -f %m -- "$frameWorkFile")))
    # Creation Date should not be older than "0" seconds
    if [ "${dateComparison}" != "0" ]
    then
        printf "Archive Process finished, but Framework creation Date was too old\n"
        exit
    else
        printf "Archive Process finished\n"
    fi
fi
printf "\n"


### Podspec Updates ###
## In case one had a specific commit id assigned to podspec, we will update it, too.
# Get last commit id
lastCommitID=$(git log --format="%H" -n 1)
# update commit id of .podspec
printf "## Updating Commit ID in ${podspecFile} to last id: ${lastCommitID}\n\n"
sed -i "" "s/${currentPodCommitIDCommand}/${lastCommitID}/g" ${podspecFile}
printf "## Updating Commit ID in ${podspecDylibFile} to last id: ${lastCommitID}\n\n"
sed -i "" "s/${currentPodCommitIDCommand}/${lastCommitID}/g" ${podspecFile}

# version of .podspec
printf "## Updating Version in ${podspecFile} to new version id: ${version}\n\n"
sed -i "" "s/${currentPodVersionCommand1}/${version}/g" ${podspecFile}
printf "## Updating Version in ${podspecDylibFile} to new version id: ${version}\n\n"
sed -i "" "s/${currentPodVersionCommand2}/${version}/g" ${podspecDylibFile}

# Pod lib Library
printf "## Pod Library Validation\n"
libSucceeded="passed validation."
if [ "${podLibLint1#*$libSucceeded}" == "$podLibLint1" ]
then
    printf "## Lib Lint failed. Perform\n\tpod lib lint ${podspecFile} --verbose\nfor more information"
else
    printf "${podLibLint1}"
fi
printf ""

if [ "${podLibLint2#*$libSucceeded}" == "$podLibLint2" ]
then
    printf "## Lib Lint failed. Perform\n\tpod lib lint ${podspecDylibFile} --verbose\nfor more information"
else
    printf "${podLibLint1}"
fi
printf ""


printf "## Commit and Push following files to git before performing push to cocoapods\n\n"
printf "${modifiedFiles}\n\n"

while true; do
    read -p "Do you wish to automatically push the changes to git to update the pods? (y/n) " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes (y) or no (n)";;
    esac
done

printf "## Generating Documentation with Jazzy (might require sudo):\nRequires SourceKitten, make sure it is installed: https://github.com/jpsim/SourceKitten\n> brew install sourcekitten>n [sudo] jazzy\n"
jazzy
printf "\n"

#In case one would also like to add new files - for docu it might be helpful...? If so, change $modifiedFiles command
#git add -A && git commit -m "Your Message"

git commit -m "RELEASE ${$}Podspec and Documentation Updated"
git push
git add -A && git commit -m "Release ${version}"
git tag "v${version}"
git push --tags
git push

printf "## Pod Specification Validation\n"
if [ "${podSpecLint1#*$libSucceeded}" == "$podSpecLint1" ]
then
    printf "## Spec Lint failed. Perform\n\tpod spec lint ${podspecFile} --verbose\nfor more information"
    exit
else
    printf "${podSpecLint1}"
fi
printf ""
if [ "${podSpecLint2#*$libSucceeded}" == "$podSpecLint2" ]
then
    printf "## Spec Lint failed. Perform\n\tpod spec lint ${podspecDylibFile} --verbose\nfor more information"
    exit
else
    printf "${podSpecLint2}"
fi
printf ""

printf "## ${podspecFile} is being pushed\n"
${podPushCommand1}
printf "\n"

printf "## ${podspecDylibFile} is being pushed\n"
${podPushCommand2}
printf "\n"
