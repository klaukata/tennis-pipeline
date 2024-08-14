import json

with open('tf_outputs.json', 'r') as file:
    data = json.load(file)

all_values = data["itegration_description"]["value"]

user_arn_value = all_values[4]["property_value"]
external_id_value = all_values[6]["property_value"]

policy = {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": user_arn_value
            },
            "Action": "sts:AssumeRole",
            "Condition": {
                "StringEquals": {
                    "sts:ExternalId": external_id_value
                }
            }
        }
    ]
}

policy_json = json.dumps(policy)

file_path = "terraform/new_trust_policy.json"

with open(file_path, 'w') as file:
    file.write(policy_json)