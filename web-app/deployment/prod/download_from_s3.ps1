# Define the S3 bucket name
$bucketName = "webapp-artifacts-bucket"

# List objects in the S3 bucket and select the latest build artifact
#$latestObject = aws s3api list-objects --bucket $bucketName --query 'reverse(sort_by(Contents, &LastModified))[0]'

# Extract the key of the latest build artifact
# $key = 

# Define the local directory where you want to download the build
$destinationDirectory = "C:\inetpub\projects\staging\web-application-automaction"

# Remove the old build files if they exist
if (Test-Path $destinationDirectory) {
    Remove-Item $destinationDirectory -Recurse -Force
}

# Create the directory if it doesn't exist
New-Item -ItemType Directory -Force -Path $destinationDirectory

# Download the build artifact from S3
aws s3 cp "s3://$bucketName/$key" "$destinationDirectory\build.zip"

# Extract the contents of the build archive
Expand-Archive -Path "$destinationDirectory\build.zip" -DestinationPath $destinationDirectory -Force

# Remove the downloaded zip file
Remove-Item "$destinationDirectory\build.zip"
