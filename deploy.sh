#!/bin/sh
## Configuration
readmeFile="README.md"
podspecFilename="NMXCore"
readmePodPushHeader="Update cocoapod spec"
readmeVersionHeader="Current Version of the NMXCore Library"
podPushCommand="pod trunk push ${podspecFilename}.podspec --verbose"
version=$1

## constants & commands
podspecFile="${podspecFilename}.podspec"
modifiedFiles=$(git diff --name-only)
# Escape special characters for sed command
podPushCommandE=$(printf '%q' "${podPushCommand}")
podPushCommandE=$(echo ${podPushCommandE})
currentPodVersionCommand=$(grep ".version" Namics-Library.podspec -n | sed 's/.*"\(.*\)".*/\1/')
currentPodCommitIDCommand=$(grep ":commit" Namics-Library.podspec -n | sed 's/.*"\(.*\)".*/\1/')

if [ "$version" == "" ]
then
version=currentPodVersionCommand
fi

## User output
printf "## Starting Deployment: ${podspecFile} ##\n"
printf "## Validating Filechanges:\n"
if [ "$modifiedFiles" == "$podspecFile" ]
then
echo "all OK"
else
echo -e "Please commit or stash all your changes first, then update your podspec file!"
fi

printf "## Updating README.md file\n\n"
# find line of update command headline and increase by one
lineNumber=$(grep "${readmePodPushHeader}" ${readmeFile} -n -i | sed 's/:.*//')
if [ "$lineNumber" == "" ]
then
printf "\n\n'pod repo push command' in ${readmeFile} could not be updated. Referenced header line:\n\t${readmePodPushHeader}\nwas not found.\nIf you want the following line:\n\t$(printf '%b' "${podPushCommand}")\nbeing noted down, make sure to either add an appropriate abstract containing\n\t'${readmePodPushHeader}'\nor modify the variable\n\t'\$readmePodPushHeader' in 'deploy.sh'\n\n"
else
readmePodInstruction=$((lineNumber+1))
sed -i "" "${readmePodInstruction}s/.*/${podPushCommandE}/" ${readmeFile}
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


## In case one had a specific commit id assigned to podspec, we will update it, too.
# Get last commit id
lastCommitID=$(git log --format="%H" -n 1)
printf "## Updating Commit ID in ${podspecFile} to last id: ${lastCommitID}\n\n"
# update commit id of .podspec
sed -i "" "s/${currentPodCommitIDCommand}/${lastCommitID}/g" Namics-Library.podspec


printf "## Generating Documentation with Jazzy (might require sudo):\nRequires SourceKitten, make sure it is installed: https://github.com/jpsim/SourceKitten\n> brew install sourcekitten>n [sudo] jazzy\\n"
jazzy
printf "\n"

printf "## Commit and Push following files to git\n\n"
printf "${modifiedFiles}"

while true; do
read -p "Do you wish to automatically push the changes to git to update the pods? (y/n) " yn
case $yn in
[Yy]* ) break;;
[Nn]* ) exit;;
* ) echo "Please answer yes (y) or no (n)";;
esac
done

#In case one would also like to add new files - for docu it might be helpful...? If so, change $modifiedFiles command
#git add -A && git commit -m "Your Message"

git commit -m "RELEASE ${$}Podspec and Documentation Updated"
git push
git add -A && git commit -m "Release 0.1.0"
git tag 'v0.1.0'
git push --tags
git push

git add -A && git commit -m "Release ${version}"
git tag 'v${version}'
git push --tags
git push

