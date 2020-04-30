# Usage: ./process.sh

# Stage 1: process TextAsset directory
if [[ ! -d "./TextAsset" ]]; then
	echo "Argument: needs directory"
else 
	cd -P "./TextAsset/"

	# rename, remove spaces and '#' symbols
	rename 's/ /_/g' *.txt
	rename 's/#//g' *.txt

	# get the list of the txt files
	files=`ls -1 *.txt`

	# for each file, if it is of type JSON, rename it to .json
	#                if it isn't, delete it
	for x in $files
	do
		type=`file $x`
		if [[ $type =~ "JSON" ]]
		then
			mv -- "$x" "$(basename -- "$x" .txt).json"
		else
			rm $x
		fi
	done

	cd -P ../.
fi


# Stage 2, directory cleaning of unknown directories
echo "Removing ./Mesh"
rm -rf ./Mesh
echo "Removing ./Animator"
rm -rf ./Animator
echo "Removing ./MonoBehaviour"
rm -rf ./MonoBehaviour
echo "Removing ./Shader"
rm -rf ./Shader
