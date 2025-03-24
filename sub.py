import subprocess

command = ["ld", "-o", "telegram.exe", "telegram.obj", "-lkernel32", "-luser32", "-lwininet"]
process = subprocess.run(command, capture_output=True, text=True)

print("STDOUT:", process.stdout)
print("STDERR:", process.stderr)
