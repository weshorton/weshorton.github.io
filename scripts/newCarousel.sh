#!/bin/bash

####################
### New Carousel ###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
####################

### Create new versions of carousel html and yaml files.

### 1. Edit the baseCarousel.html file to point to new yaml
### 2. Create appropriate yaml with correct paths. (Check for naming convention)

#################
### Arguments ###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#################

### Descriptions
### imageDir - directory containing images to put in carousel. Should be named 01_XXX, 02_XXX, etc.
### newName - name to call the .yaml file and to use to update the .html file

### Note that newName is independent of the imageDir directory name, although they can be the same and being related in some way might help. Make sure newName is descriptive enough to make sense when reading markdown pages where this carousel is included.

### Assignments
imageDir=$1
newName=$2

PROJ=~/my_tool_repos/weshorton.github.io/
HTML=$PROJ/_includes/carousels
YAML=$PROJ/_data/carousels
ORIG=$HTML/baseCarousel.html
NEW=$HTML/$newName\.html

### Edit base
cp $ORIG $NEW
sed -i '' "s|site\.data\.carousel\.images|site\.data\.carousels\.$newName\.images|g" $NEW

### Check File Naming - TO DO
### Read in files and make sure prefix is numeric

### Make yaml file
echo "images:" > $YAML/$newName.yaml

### Get relative path (only works if directory images are in is _Something)
imgPath=${imageDir#*/_}

### Make sure imgPath has / on either side
imgPath="/"$imgPath"/"


for file in `ls $imageDir`; do
	printf "  - image: %s%s\n" $imgPath $file >> $YAML/$newName.yaml
done
