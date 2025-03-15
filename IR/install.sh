!#/bin/bash

# Source directory containing .tar.gz files
SOURCE_DIR="./bins/archives"  # Change this to your actual source directory

# Target directory where binaries will be moved
TARGET_DIR="./bins/all-distros/"  # Change this to your desired output directory

# List of binary names to extract (Modify this list as needed)
BINARIES=("btop" "capa" "lazydocker" "")  # Replace with actual binary names

# Create target directory if it doesn’t exist
mkdir -p "$TARGET_DIR"

# Loop through all tar.gz files in the source directory
for archive in "$SOURCE_DIR"/*.tar.gz; do
    if [[ -f "$archive" ]]; then
        echo "Processing: $archive"

        # Loop through each binary in the list
        for BINARY_NAME in "${BINARIES[@]}"; do
            # Find the exact binary path inside the archive
            BINARY_PATH=$(tar -tzf "$archive" | grep "/$BINARY_NAME$")

            if [[ -n "$BINARY_PATH" ]]; then
                # Extract just the binary file
                tar -xzf "$archive" "$BINARY_PATH"
                
                # Move the binary to the target directory
                mv "$BINARY_PATH" "$TARGET_DIR"
                
                echo "Extracted and moved: $BINARY_NAME from $archive to $TARGET_DIR"
            else
                echo "WARNING: Binary $BINARY_NAME not found in $archive"
            fi
        done
    fi
done

echo "All extractions completed!"

    echo "Moving binaries from linux-gnu"
    mv -f bin/all-distros/* /usr/bin

echo "Binaires have been moved successfully!"
