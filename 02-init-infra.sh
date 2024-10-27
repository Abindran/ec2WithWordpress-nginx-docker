#!/bin/bash

# Function to generate a random password
generate_password(){
    < /dev/random tr -dc A-Za-z0-9 | head -c20
}

# Generate random password
DB_PASSWORD=$(generate_password)

cat <<EOF > .env
DB_PASSWORD=$DB_PASSWORD
EOF

echo "Creating a Docker app network"
docker network create app-network
docker-compose -f docker-infra-compose.yml up -d 

echo "Infra setup complete. Please wait 2 minutes for the services to be up and running"

# Loading animation for 2 minutes
seconds=0
max_wait=120
while [ $seconds -lt $max_wait ]; do
    if docker-compose -f docker-infra-compose.yml ps | grep -q "starting\|unhealthy"; then
        echo -ne "Waiting for services to start: [$(printf "%0.s=" $(seq 1 $((seconds/2))))$(printf "%0.s " $(seq $(((120-seconds)/2)) 1 59))]\r"
        sleep 1
        ((seconds++))
    else
        echo -ne "\nAll services are up and running!\n"
        echo "Generated .env file with random password."
        break
    fi
done

if [ $seconds -eq $max_wait ]; then
    echo -e "\nReached the maximum wait time of 2 minutes."
fi
