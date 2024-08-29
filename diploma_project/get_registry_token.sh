yc config profile activate default
yc config profile delete zakamaldin-diploma-registry-sa-profile
yc iam key create --service-account-name zakamaldin-diploma-registry-sa --output key.json
yc config profile create zakamaldin-diploma-registry-sa-profile
yc config set service-account-key key.json
yc iam create-token > jenkins/registry_token
yc config profile activate default