#!/bin/bash

set -euo pipefail

echo "--- Enforce daily budget"

source tests/buildkite/conftest.sh

if [[ $is_release_branch == 1 ]]
then
  echo "Automatically approving all test jobs for release branches"
else
  aws lambda invoke --function-name XGBoostCICostWatcher --invocation-type RequestResponse --region us-west-2 response.json
  python3 tests/buildkite/enforce_daily_budget.py --response response.json
fi
