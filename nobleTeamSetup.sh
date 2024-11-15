#!/bin/bash

# Define Noble Team members and their passwords
declare -A noble_team
noble_team=(
  [carter]="password1"
  [kat]="password2"
  [jun]="password3"
  [emile]="password4"
  [jorge]="password5"
  [six]="password6"
)

# Create accounts and set passwords
for member in "${!noble_team[@]}"; do
  sudo useradd -m -s /bin/bash "$member"
  echo "${member}:${noble_team[$member]}" | sudo chpasswd
  sudo usermod -aG sudo "$member"
done

echo "All Noble Team members have been created and added to the sudo group."
