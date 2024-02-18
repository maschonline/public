#!/bin/bash

for f in *; do 
    mv -- "$f" "$(printf '%s\n' "$f" | sed 's/ü/ue/g')"
done

for f in *; do 
    mv -- "$f" "$(printf '%s\n' "$f" | sed 's/ö/oe/g')"
done

for f in *; do 
    mv -- "$f" "$(printf '%s\n' "$f" | sed 's/ä/ae/g')"
done

for f in *; do 
    mv -- "$f" "$(printf '%s\n' "$f" | sed 's/Ü/Ue/g')"
done

for f in *; do 
    mv -- "$f" "$(printf '%s\n' "$f" | sed 's/Ö/Oe/g')"
done

for f in *; do 
    mv -- "$f" "$(printf '%s\n' "$f" | sed 's/Ä/Ae/g')"
done

for f in *; do 
    mv -- "$f" "$(printf '%s\n' "$f" | sed 's/ß/ss/g')"
done

for f in *; do 
    mv -- "$f" "$(printf '%s\n' "$f" | sed 's/[^0-9a-zA-Z.-]/_/g')"
done

