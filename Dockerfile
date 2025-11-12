# Simple Dockerfile for testing docker/metadata-action
FROM alpine:3.19

# Add a label to test metadata
LABEL maintainer="test@example.com"
LABEL description="Test image for docker/metadata-action"

# Create a simple test file
RUN echo "Test Docker image for metadata-action" > /test.txt

# Default command
CMD ["cat", "/test.txt"]
