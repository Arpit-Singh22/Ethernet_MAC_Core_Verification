import subprocess, os

# Path to Questa installed on Windows
QUESTA = "/mnt/c/questasim64_2024.1/win64/vsim.exe"

RUN_DO = "run_test.do"  # must be in same folder

def run_test(test):
    print(f"\n=== Running {test} ===")

    # Ensure log directory exists
    os.makedirs("logs", exist_ok=True)

    # Questa command (CLI mode)
    cmd = (
        f'"{QUESTA}" -c '
        f'-do "set testname {test}; do {RUN_DO};"'
    )

    result = subprocess.run(
        cmd,
        shell=True,
        capture_output=True,
        text=True
    )

    log_file = f"logs/{test}.log"
    with open(log_file, "w") as f:
        f.write(result.stdout)
        f.write(result.stderr)

    # PASS/FAIL detection
    fail_markers = ["UVM_ERROR", "UVM_FATAL", "TEST FAILING"]

    failed = any(marker in result.stdout for marker in fail_markers)

    if failed:
        print(f"❌ FAILED: {test}   (see {log_file})")
        return False

    print(f"✔ PASSED: {test}")
    return True


def regression():
    # Read tests.list
    tests = [
        t.strip()
        for t in open("tests.list").read().splitlines()
        if t.strip() != "" and not t.startswith("#")
    ]

    passed = sum(run_test(t) for t in tests)

    print("\n===================================")
    print(f"REGRESSION DONE: {passed}/{len(tests)} tests passed")
    print("===================================")


if __name__ == "__main__":
    regression()

