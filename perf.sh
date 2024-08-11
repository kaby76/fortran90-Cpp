# Generated from trgen 0.23.2

# People often specify a test file directory, but sometimes no
# tests are provided. Git won't check in an empty directory.
# Test if the test file directory does not exist, or it is just
# an empty directory.
if [ ! -d ../examples ]
then
    echo "No test cases provided."
    exit 0
elif [ ! "$(ls -A ../examples)" ]
then
    echo "No test cases provided."
    exit 0
fi

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

# Get a list of test files from the test directory. Do not include any
# .errors or .tree files. Pay close attention to remove only file names
# that end with the suffix .errors or .tree.
files2=`find ../examples -type f | grep -v '.errors$' | grep -v '.tree$'`
files=()
for f in $files2
do
    triconv -f utf-8 $f > /dev/null 2>&1
    if [ "$?" = "0" ]
    then
        files+=( $f )
    fi
done

# Parse all input files.
# Individual parsing.
rm -f parse.txt
for f in ${files[*]}
do
    trwdog ./build/Release/Test.exe -prefix individual $f >> parse.txt 2>&1
    xxx="$?"
    if [ "$xxx" -ne 0 ]
    then
        status="$xxx"
    fi
done
# Group parsing.
echo "${files[*]}" | trwdog ./build/Release/Test.exe -x -prefix group >> parse.txt 2>&1
status=$?

exit 0
