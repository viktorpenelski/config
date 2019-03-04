#!/bin/bash

# this script requires jq: https://stedolan.github.io/jq/download/

getSteamId() {
    local __steamName=$1

    local __id=$(curl https://steamid.venner.io/raw.php?input=$__steamName | jq .steamid64 -r)

    echo $__id
}

# Example of .dacProfile:
# "dacProfile": {
#     "rank": 18,
#     "queenRank": 0,
#     "steamId": "76561198925026970",
#     "score": 1,
#     "matchesPlayed": 10,
#     "lastMatches": null,
#     "onDutyCourier": "h001_e000",
#     "candies": 13,
#     "availableCouriers": [
#         "h001_e000"
#     ],
#     "totalRank": 0
# },
getRankForSteamId64() {
    local __id=$1

    local __baseurl="http://www.autochess-stats.com/backend/api/dacprofiles/$__id"

    # Request the given profile to be refreshed for latest rank
    curl -X POST $__baseurl/requestfetch/ -H 'Content-Length: 0'

    local __jsonPathToRank=".dacProfile.rank"
    local __rank=$(curl $__baseurl | jq $__jsonPathToRank --raw-output)

    echo "$__rank"
}

calculateForRank() {
    local __rank=$1

    if [ $__rank -eq -1 ]; then
        echo "Unranked"
        return 0
    fi

    local __divisor=9
    local __tier=$(($__rank / $__divisor))
    local __level=$(($__rank % $__divisor))

    if [ $__level -eq 0 ]; then
        __tier=$(($__tier-1))
        __level=9
    fi

    ranks=( 
        [0]="Pawn" 
        [1]="Knight" 
        [2]="Bishop"
        [3]="Rook"
        [4]="King"
        [5]="Queen"
    )

    #TODO(vic) handle King and Queen as their ranks have different representation
    echo "${ranks[$__tier]}-$__level"
}

name=$1

steamid64=$(getSteamId $name)

if [ -z $steamid64 -o "$steamid64" == "null" ]; then
    echo "Failed to retrieve steamId for $name"
    exit 1
fi

echo "steamid64 for $name is: $steamid64"

rank=$(getRankForSteamId64 $steamid64)

if [ -z $rank ]; then
    echo "Failed to check rank for for $name"
    exit 1
fi

echo "rank $rank"

echo "$name is $(calculateForRank $rank)"
