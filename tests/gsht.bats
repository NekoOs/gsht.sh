#!/usr/bin/env bats

setup_file() {
    cd "$(dirname "$BATS_TEST_FILENAME")" || exit

    (cd ../src && ./gsht.sh gsht.sh --output "$BATS_RUN_TMPDIR/gsht")

    chmod +x "$BATS_RUN_TMPDIR/gsht"
}

@test "test_name" {
    run "$BATS_RUN_TMPDIR/gsht" ./../examples/deployment_automation/deploy/scripts/run_deploy.sh --output="$BATS_RUN_TMPDIR/deploy"

    [ "$status" -eq 0 ]

    diff "$BATS_RUN_TMPDIR/deploy" ./../examples/deployment_automation/bin/deploy.sh

    [ "$status" -eq 0 ]
}
