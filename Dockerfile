# Start with a base Python image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the application files
COPY src/ /app

# Install dependencies
RUN pip install -r requirements.txt

# Expose the application port
EXPOSE 8080

# Command to run the app
CMD ["python", "app.py"]
